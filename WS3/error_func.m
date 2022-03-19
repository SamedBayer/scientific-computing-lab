function y = error_func(mu, dt, t_end,sol)

y= sqrt (dt/t_end * sum(  (exact_solution(mu,dt,t_end) -  sol).^2  ) ) ;

end
