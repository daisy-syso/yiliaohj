# Utils::Random
# 随机密码相关的工具类
module Utils
  class Random
    def self.digital_code(length)
      SecureRandom.random_number(('9' * length).to_i).to_s.rjust(length, '0')
    end
  end
end
