package com.ansbeno.services;

import java.util.List;
import java.util.Optional;

public interface IService<T, I> {

      List<T> findAll();

      List<T> findByKeyword(String keyword);

      Optional<T> findById(I id);

      T save(T entity);

      void deleteById(I id);

      void delete(T entity);
}
