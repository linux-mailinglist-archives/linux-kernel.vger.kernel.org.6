Return-Path: <linux-kernel+bounces-447025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6054C9F2C33
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE64C1883A99
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA7A1FFC73;
	Mon, 16 Dec 2024 08:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ZJNGpFmu"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3C41FFC44
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 08:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734338916; cv=none; b=dzfwF6hpAFEzYzesdBM8RmQxvBjwLWb0D0CeuhkGbgX4BLAagzz0JBL8rP7jBwX1Lru34E2JNQP0XwMhlzU5qnFaA426ANiphph+j3LaGYo4VC92V1cxinKdPR6EfIMW97atiOdkV2oGX3df1pl005YmLK1X1DFEiT/R7a0NDkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734338916; c=relaxed/simple;
	bh=6OMK+HsK+VbnZzby8IXvMCez2+AxPVQkeAi81ytIO6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Da5NblwWpgH0Y3pvmyThDgK3VZuhoa4Av4XjU3hsokO3ybIPsP2Lqg6KLbU0TAfs72Tu9DaLip1qnRauEys4B5AS8YCFZcod7FuXilwPO3/AcNylSQCYS7We09CZa2Snx/reCUwnav9KktQWAzdJMUyGHFfyTbuL5GWZHVS6HSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ZJNGpFmu; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2166360285dso31765825ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 00:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1734338914; x=1734943714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZPlunLBlln7QYb6AUUO3djXlFosdjLIQj/QlK3o4jU=;
        b=ZJNGpFmuSuPQ+lV2BcWW3IYmQRj3MV8+hB0yIM4wLf8NHHEL+cYi0NUpOCX7R+qyrl
         XjgyfWi0CXQ+aZiYGUdioqp/Q3AVNYwduw/l5IJUzmJOyCQDFFT3G6GBjwDrV5QBZ/oG
         EsgYR3Y4dgjQ9bbnwjhZanFGOOgqvwwmolxlj02EqyPcUFuCZaXdTG+VJHkRfnrrWuFo
         ctcL7NKyjiplRaaKQiYOQ1dbzAXmZgCiIHsbJT+b8socoA+T7w6T47Vk2x+vOxeBBWec
         7/g7zfI8Hwd5V6uT7cWgTJq5OjLy2u9xRjvkTiU/T4vwoK8ut6wGFCKgR7ksNsv+CqRq
         v31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734338914; x=1734943714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ZPlunLBlln7QYb6AUUO3djXlFosdjLIQj/QlK3o4jU=;
        b=jc5dVUdE6ViaFhx7IlMmETPQCeVoMnVsfGX+l9QxCxlpj+GnbO9q02/m+TG0NAvFiU
         Q2cSlba1+TPE/E1GoSZ8v3vPnIFG+AT03tf9YcGou0cXZt9CuHwApo0gEbFnzyKl2q/S
         q72uKCKczUV9RPaHtzxYsk9XclteygPrMORD6iFJh/Y0zkvVjj4q4/NnqzzAgZpeqjJv
         6u9sdFPjvjQKyG9p4jFwlDBthuQ9Iin0RatH1WXDYhQ8CO1odkvm9ea4GvKkY1JBwJw8
         D4qrKyyTKBD7oXa0CbqtTsmVKe7ZPRVwJpvC4vDiyUlS32TVDE+HuNaGaWuaKPNm4Cp2
         XmzA==
X-Forwarded-Encrypted: i=1; AJvYcCUyZuQY8g+JxZQA1oTHkQ+eaMz1KnXnJq/7dI0v7jUGyIXb7LoNuqT0emETuxDkGNb5WzZUan1xCsBaO24=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLFhE86DwYPca61bABf+QS63cealxe03BqVe3aMhH8Nq3mUwyX
	INvxBywcZBZ2C1lswqfoz19rTqRm0cKfrLNqy7FvC++zCuHNwIp0gHaS9K/w6/U=
X-Gm-Gg: ASbGncscHf8H0GD1/1+8WqDcmEtgvWq8XdzT3iSL8Oa656NYrYcMzW3O4xVS4Sma2vA
	rRiFvS2gePxW3LlurpOlTsOZ03T0IK+TbeG4wKIbWBuGttT+ly5z9Ww+kj5cJaGxLacowuH0p/U
	YjDi14lkBeNg4tMBio3tYq/SYHEzn1M0Pc2Rr8Nrpaf0qj6LEZ3Xbdcr66BNVePJOGjyhlZyUAd
	SAuZBLCYRwqTpW9TgTACcJkpp6In7aceSup88+oDtJXLouTvOKdnaXcqK/e+XwUPTLSIQFzu0s3
	MI0xGV4PpGcOREo=
X-Google-Smtp-Source: AGHT+IFoNCn1xjwdvfD5tU8wcob3LmcqUZZYdSpRKH7XSPi+k1Q2z7DhQmm+kma0y1vvzp+aMNnp1w==
X-Received: by 2002:a17:902:e84f:b0:212:514:b30a with SMTP id d9443c01a7336-218929808c8mr181238975ad.12.1734338914542;
        Mon, 16 Dec 2024 00:48:34 -0800 (PST)
Received: from localhost.localdomain ([223.185.130.105])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e501d0sm37711495ad.116.2024.12.16.00.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 00:48:33 -0800 (PST)
From: Anup Patel <apatel@ventanamicro.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Rahul Pathak <rpathak@ventanamicro.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Atish Patra <atishp@atishpatra.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [RFC PATCH 0/8] Linux SBI MPXY and RPMI drivers
Date: Mon, 16 Dec 2024 14:18:09 +0530
Message-ID: <20241216084817.373131-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SBI v3.0 MPXY extension [1] and RPMI v1.0 [2] specifications are
in stable state and under ARC review at the RISC-V International so
as part of the RVI process we would like to receive an early feedback
on the device tree bindings and mailbox drivers hence this series.

Currently, most of the RPMI and MPXY drivers are in OpenSBI whereas
for Linux only has SBI MPXY mailbox controller driver and RPMI clock
driver. This series will be expanded in the future to include some
more RPMI drivers and ACPI support.

These patches can be found in the riscv_sbi_mpxy_mailbox_v1 branch at:
https://github.com/avpatel/linux.git

To test these patches, boot Linux on "virt,rpmi=on" machine with
latest OpenSBI and QEMU from the dev-upstream QEMU branch at:
https://github.com/ventanamicro/qemu.git

[1] https://github.com/riscv-non-isa/riscv-sbi-doc/releases
[2] https://github.com/riscv-non-isa/riscv-rpmi/releases

Anup Patel (7):
  riscv: Add new error codes defined by SBI v3.0
  dt-bindings: mailbox: Add bindings for RPMI shared memory transport
  dt-bindings: mailbox: Add bindings for RISC-V SBI MPXY extension
  RISC-V: Add defines for the SBI message proxy extension
  mailbox: Add common header for RPMI messages sent via mailbox
  mailbox: Add RISC-V SBI message proxy (MPXY) based mailbox driver
  dt-bindings: clock: Add bindings for RISC-V RPMI clock service group

Rahul Pathak (1):
  clk: Add clock driver for the RISC-V RPMI clock service group

 .../bindings/clock/riscv,rpmi-clock.yaml      |  78 ++
 .../mailbox/riscv,rpmi-shmem-mbox.yaml        | 135 +++
 .../bindings/mailbox/riscv,sbi-mpxy-mbox.yaml |  54 +
 arch/riscv/include/asm/sbi.h                  |  69 ++
 drivers/clk/Kconfig                           |   8 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/clk-rpmi.c                        | 588 +++++++++++
 drivers/mailbox/Kconfig                       |  11 +
 drivers/mailbox/Makefile                      |   2 +
 drivers/mailbox/riscv-sbi-mpxy-mbox.c         | 979 ++++++++++++++++++
 include/linux/mailbox/riscv-rpmi-message.h    | 218 ++++
 11 files changed, 2143 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/riscv,rpmi-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/mailbox/riscv,rpmi-shmem-mbox.yaml
 create mode 100644 Documentation/devicetree/bindings/mailbox/riscv,sbi-mpxy-mbox.yaml
 create mode 100644 drivers/clk/clk-rpmi.c
 create mode 100644 drivers/mailbox/riscv-sbi-mpxy-mbox.c
 create mode 100644 include/linux/mailbox/riscv-rpmi-message.h

-- 
2.43.0


