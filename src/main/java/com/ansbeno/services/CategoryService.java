package com.ansbeno.services;

import java.util.List;
import java.util.Optional;

import com.ansbeno.entities.Category;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import jakarta.transaction.Transactional;

@ApplicationScoped
public class CategoryService implements IService<Category, Long> {

      @PersistenceContext(unitName = "demo")
      private EntityManager em;

      @Override
      public List<Category> findAll() {
            return em.createQuery("SELECT c FROM Category c", Category.class).getResultList();
      }

      @Override
      public Optional<Category> findById(Long id) {
            return Optional.ofNullable(em.find(Category.class, id));
      }

      @Override
      @Transactional
      public Category save(Category entity) {
            if (entity.getId() == null) {
                  em.persist(entity);
            } else {
                  entity = em.merge(entity);
            }
            return entity;
      }

      @Override
      @Transactional
      public void deleteById(Long id) {
            em.createQuery("DELETE FROM Category c WHERE c.id = :id")
                        .setParameter("id", id)
                        .executeUpdate();
      }

      @Override
      @Transactional
      public void delete(Category entity) {
            em.remove(entity);
      }

      @Override
      public List<Category> findByKeyword(String keyword) {
            TypedQuery<Category> query = em.createQuery(
                        "SELECT c FROM Category c WHERE LOWER(c.name) LIKE LOWER(:keyword) OR c.description LIKE :keyword",
                        Category.class);
            query.setParameter("keyword", "%" + keyword + "%");
            return query.getResultList();
      }

      public List<String> getNames() {
            TypedQuery<String> query = em.createQuery("SELECT c.name FROM Category c", String.class);
            return query.getResultList();
      }

}
