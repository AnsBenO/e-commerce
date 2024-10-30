package com.ansbeno.services;

import java.util.List;
import java.util.Optional;

import com.ansbeno.entities.Product;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import jakarta.transaction.Transactional;

@ApplicationScoped
public class ProductService implements IService<Product, Long> {

      @PersistenceContext(unitName = "demo")
      private EntityManager em;

      @Override
      public List<Product> findAll() {
            return em.createQuery("SELECT p FROM Product p", Product.class).getResultList();
      }

      @Override
      public Optional<Product> findById(Long id) {
            return Optional.ofNullable(em.find(Product.class, id));
      }

      public List<Product> findByCategory(String categoryName) {
            TypedQuery<Product> query = em.createQuery("""
                        SELECT p FROM Product p
                        WHERE p.category.name = :name
                        """,
                        Product.class);
            query.setParameter("name", categoryName);
            return query.getResultList();
      }

      @Override
      @Transactional
      public Product save(Product entity) {
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
            em.createQuery("DELETE FROM Product p WHERE p.id = :id")
                        .setParameter("id", id)
                        .executeUpdate();
      }

      @Override
      @Transactional
      public void delete(Product entity) {
            em.remove(entity);
      }

      @Override
      public List<Product> findByKeyword(String keyword) {
            TypedQuery<Product> query = em.createQuery("""
                        SELECT p FROM Product p
                        WHERE LOWER(p.name) LIKE LOWER(:keyword)
                        """, Product.class);
            query.setParameter("keyword", "%" + keyword + "%");
            return query.getResultList();
      }

}
