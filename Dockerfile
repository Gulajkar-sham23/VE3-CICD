# Stage 1: Build the PHP application
FROM php:7.4-fpm AS builder

# Set the working directory
WORKDIR /var/www/html

# Install PHP extensions
RUN docker-php-ext-install mysqli

# Copy application code
COPY . /var/www/html

# Stage 2: Set up Nginx
FROM nginx:alpine

# Copy Nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Copy built PHP application from builder stage
COPY --from=builder /var/www/html /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
