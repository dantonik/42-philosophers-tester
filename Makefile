# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dantonik <dantonik@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/12/25 07:04:54 by dantonik          #+#    #+#              #
#    Updated: 2022/12/25 07:29:32 by dantonik         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

CC				=	gcc
CFLAGS			=	-Wall -Wextra -Werror

re:
	@make fclean -C ../
	@make -C ../

clean:
	@rm -rf fails
	@rm test

.PHONY:		re clean