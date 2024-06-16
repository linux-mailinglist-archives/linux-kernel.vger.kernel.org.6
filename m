Return-Path: <linux-kernel+bounces-216377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A22909EAD
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 19:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69FB61F21379
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 17:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795A528DC7;
	Sun, 16 Jun 2024 17:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="sW/I5ZkR"
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63F412E7E;
	Sun, 16 Jun 2024 17:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718558350; cv=none; b=KNmTclpzATWi30ejK29wRrRJRN/2OJa/0Zrl2syx7hVy08LdPDiSYYmswQ6VAUhjOPHfYcL6wtzA4NoyUs92NTB+5QDq8AfDwI3XrxCONcAURY/hotgHGhSrssnar0HjUoHZ/uK6vVZkpwjWx7MYbPX7XQfnorFZ/jkF6Tc1nZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718558350; c=relaxed/simple;
	bh=19G1J8ZnkoXJsDkgERRYUzgb7CPmA8BJJ7qmlahKLmM=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=PALWZymDXm3ftPOen4CuwlqobZdVQY+ES42eHe3yHOUqxJ5nHYqQ0H2Q6IUhD6Pgi0oU9fiSGkbC9Y0b+E9pos8ggywauhz+64r1G6loanIgJBser1muWdsNdX3kvujnB5TDt0s3m6hQFo9/TTtg4qUxMQ4QbOZ5jXciLGl27qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=sW/I5ZkR; arc=none smtp.client-ip=203.205.221.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1718558344; bh=jJ9Igh0peCp3hD61YPVPtVN+YWS56XTwc+sXFzKDOKo=;
	h=From:To:Cc:Subject:Date;
	b=sW/I5ZkRAhhBdauS/bOYBU0VZFVKKOQ/29trNSJYsKa/Aooko8xc8bGuWA+OzD1qp
	 lWh/GImpIPZPO3w+m5yEO0W2ruaOzrwdreZ0wnHQtHQgqlvt8CkHgV/0W7YV2baTCr
	 ZrRXnwne88vm+TQjGaZHqqweVXs8UMLgKVaiHzJo=
Received: from cyy-pc.lan ([240e:379:2260:ed00:cd33:e8cf:d8f9:bed3])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 4C03E806; Mon, 17 Jun 2024 01:19:00 +0800
X-QQ-mid: xmsmtpt1718558340ts5w4gw51
Message-ID: <tencent_BC64B7B1876F5D10479BD19112F73F262505@qq.com>
X-QQ-XMAILINFO: MSPab3JKqisNu/J589iYOw3sGBU5TouEdZaUsX9QtkV5yGQBb/Ox4LxkgOENk6
	 oIindeAOoyurwVY774zMfvHVHOpgbcGHXtfQ4K5dJwNPaHmhqT2fWTYIn4CxswKGxDrx99dRkgRB
	 CTXCaN2rwdoFiTMuPlI1jpUSWiZiBMd8g9GPthbS5RMpae8Jp59ghRrBz6LUy0Y9ZlXMq9bFsdnB
	 nKODH5WP/nrq47fMfMsLx1mPR8lpbTo5QT/8Y4rx2c4n55a2tBk5XTjS1kYUxrPE7DjiM7Iyen4G
	 BUzXn1IbGfqAP7wyHTcgJ5X8zQq+fCbjz0nOq5Yn4WMps4QEGAlOHtwYigOJio5V+Wa8BH51ZLIT
	 /07YDz/pt1MhXXVNpjkKAp6lgLY0o/gBhzCDHbHPXm6PEP2pUvVJNs4SorrUEyvVdO9gx1MfXsXf
	 w+yM0bWefvcZtv+bUSGaF0blDOPaj5i4HDoaQO2zrfjc5RfJMf9DYM41cASOA1UkCYjXKZZPPbhd
	 8h9FBJ6lap2WjWAIVgJrDuOaeJv5ZEEI9bTxF9DZiPpijEV4Qi82NA7Hs8n1+fcaCq3hEfnKzjk8
	 NkaMUrnZKl1EdvPwjrDOmjshOdfGdG/frJwH9f1alr3SJn8kPb8O3IY5Jfnc1JpH8L3JuoN4peSZ
	 9maXCOu+bZ0hv4/XoZxSzYxiBtJ33xgmd2UQqzzRFx2wYZlTpwFEvj2bfSqQXAjI/6OqQezE4eGR
	 54IFG3vHZqFPHfRz2+R6b0vzFFEKNIA7xd/2jTrEPogfRJlzysLfDZA9DNxH+ATzp23AojaDtmTB
	 cgHqPX50Jz6UHt4DB9i2t5qy55yZEQOH3ekB+3xZZ5k8EQxEcujX0bl1ZuEGQJmeDZVeERQQ4wK4
	 /6tuCNkkIhw1zvKR/PadnRcfBJyal+c2mYcV+3OFRQ2Ji3kCF6FlKEj3dxlbe9yCAH9CPTN+ltQu
	 0g881itcy7jTYZt/m3okons20gmlUvsgBJQNXVOgODk7H3rJ2Cu/pjgmW1Dqx+gejaKGVeG/YyGs
	 5An/V/eMKQxva58m9+DR+rm+ZNmscM0GPMVU5gMeRcHxI4g/Oa
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup.patel@wdc.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH v1 0/9] riscv: add initial support for SpacemiT K1
Date: Mon, 17 Jun 2024 01:18:52 +0800
X-OQ-MSGID: <20240616171852.3074283-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SpacemiT K1 is an ideal chip for some new extension such as RISC-V Vector
1.0 and Zicond evaluation now. Add initial support for it to allow more
people to participate in building drivers to mainline for it.

This kernel has been tested upon Banana Pi BPI-F3 board on vendor U-Boot
bootflow generated by Armbian SDK[1] and patched OpenSBI[2] to enable
Zicboz, which does not in the vendor dts on its U-Boot. Then successfully
booted to busybox on initrd with this log[3].

[1] https://github.com/BPI-SINOVOIP/armbian-build/tree/v24.04.30
[2] https://gist.github.com/cyyself/a07096e6e99c949ed13f8fa16d884402
[3] https://gist.github.com/cyyself/a2201c01f5c8955a119641f97b7d0280

Yangyu Chen (9):
  dt-bindings: vendor-prefixes: add spacemit
  dt-bindings: riscv: Add SpacemiT X60 compatibles
  dt-bindings: riscv: add SpacemiT K1 bindings
  dt-bindings: timer: Add SpacemiT K1 CLINT
  dt-bindings: interrupt-controller: Add SpacemiT K1 PLIC
  riscv: add SpacemiT SOC family Kconfig support
  riscv: dts: add initial SpacemiT K1 SoC device tree
  riscv: dts: spacemit: add Banana Pi BPI-F3 board device tree
  riscv: defconfig: enable SpacemiT SoC

 .../sifive,plic-1.0.0.yaml                    |   5 +-
 .../devicetree/bindings/riscv/cpus.yaml       |   1 +
 .../devicetree/bindings/riscv/spacemit.yaml   |  24 ++
 .../bindings/timer/sifive,clint.yaml          |   4 +-
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/riscv/Kconfig.socs                       |   5 +
 arch/riscv/boot/dts/Makefile                  |   1 +
 arch/riscv/boot/dts/spacemit/Makefile         |   2 +
 arch/riscv/boot/dts/spacemit/bananapi-f3.dts  |  19 ++
 arch/riscv/boot/dts/spacemit/k1.dtsi          | 281 ++++++++++++++++++
 arch/riscv/configs/defconfig                  |   1 +
 11 files changed, 343 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/riscv/spacemit.yaml
 create mode 100644 arch/riscv/boot/dts/spacemit/Makefile
 create mode 100644 arch/riscv/boot/dts/spacemit/bananapi-f3.dts
 create mode 100644 arch/riscv/boot/dts/spacemit/k1.dtsi

-- 
2.45.1


