Return-Path: <linux-kernel+bounces-298721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A94B295CAA0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 12:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC3EA1C2123B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAEB1862B2;
	Fri, 23 Aug 2024 10:39:56 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC5C13AD33;
	Fri, 23 Aug 2024 10:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724409596; cv=none; b=fXUT4TRGLEBDRD9ZNxNhS4QzNpZ87uVDBZeiZ5ORKCF8W7IpfHgIw6aW06Eid47RxVbzxo+hMUf7jSd6IBV4nhNsQ7cQMV/ROiY7biF4uThNwGdcfym8ilaP03V1lrBDJ/8/Ubz4/Woa3f49yCLGKXoujEM+UyxXv5lhYdPI4iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724409596; c=relaxed/simple;
	bh=T2xCTpfWWrD4xlq547qLcZjxFmySwcHKW8k2qQLLlRg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o6ODG256ESZKMubUfFfx1ZtOIrcAiRW/SyrzHvMRfkokYXUBCt8ixGasmc/dG32DLQ5NGRGmLIo5ueUpxwi5MGV2RPqdnUBdWgb7X6DbzyQFWGbfysEya7/oSaAeOvvG1w03vxMirIN5KlB7kuIafjffM3QNQx0coU/XEY7WctU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.10.34])
	by gateway (Coremail) with SMTP id _____8CxOur4ZshmtFUdAA--.62161S3;
	Fri, 23 Aug 2024 18:39:52 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.10.34])
	by front1 (Coremail) with SMTP id qMiowMAxYeHqZshm6jcfAA--.4588S4;
	Fri, 23 Aug 2024 18:39:51 +0800 (CST)
From: Tianyang Zhang <zhangtianyang@loongson.cn>
To: corbet@lwn.net,
	alexs@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	tglx@linutronix.de,
	jiaxun.yang@flygoat.com,
	gaoliang@loongson.cn,
	wangliupu@loongson.cn,
	lvjianmin@loongson.cn,
	zhangtianyang@loongson.cn,
	yijun@loongson.cn,
	mhocko@suse.com,
	akpm@linux-foundation.org,
	dianders@chromium.org,
	maobibo@loongson.cn,
	xry111@xry111.site,
	zhaotianrui@loongson.cn,
	nathan@kernel.org,
	yangtiezhu@loongson.cn,
	zhoubinbin@loongson.cn
Cc: loongarch@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH v11 5/7] irqchip/loongson-eiointc: Rename CPUHP_AP_IRQ_LOONGARCH_STARTING
Date: Fri, 23 Aug 2024 18:39:34 +0800
Message-Id: <20240823103936.25092-3-zhangtianyang@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240823103936.25092-1-zhangtianyang@loongson.cn>
References: <20240823103936.25092-1-zhangtianyang@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxYeHqZshm6jcfAA--.4588S4
X-CM-SenderInfo: x2kd0wxwld05hdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KrWUtrWDWFyrCw4kXw13trc_yoW8AFyUpF
	W5Ca4vgr1Fk348ur98K3srAr15GwnxJrW7AFW7Waya9r9Ika48Cr1rtFyjvFyxGayjq3Wj
	ga1vvr4Dua9YkrbCm3ZEXasCq-sJn29KB7ZKAUJUUUUD529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBCb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6Fy26r45twAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0x
	vY0x0EwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
	7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVWDJVCq3wCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42
	IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUx2Q6DUUUU

From: Huacai Chen <chenhuacai@loongson.cn>

Rename CPUHP_AP_IRQ_LOONGARCH_STARTING to CPUHP_AP_IRQ_EIOINTC_STARTING
because the upcoming AVECINTC irqchip driver will introduce a new state
named CPUHP_AP_IRQ_AVECINTC_STARTING.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>
---
 drivers/irqchip/irq-loongson-eiointc.c | 4 ++--
 include/linux/cpuhotplug.h             | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index 34b5ca2f5e62..c756b7aa8055 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -398,8 +398,8 @@ static int __init eiointc_init(struct eiointc_priv *priv, int parent_irq,
 
 	if (nr_pics == 1) {
 		register_syscore_ops(&eiointc_syscore_ops);
-		cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_LOONGARCH_STARTING,
-					  "irqchip/loongarch/intc:starting",
+		cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_EIOINTC_STARTING,
+					  "irqchip/loongarch/eiointc:starting",
 					  eiointc_router_init, NULL);
 	}
 
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 51ba681b915a..e49807f7805c 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -145,7 +145,7 @@ enum cpuhp_state {
 	CPUHP_AP_IRQ_ARMADA_XP_STARTING,
 	CPUHP_AP_IRQ_BCM2836_STARTING,
 	CPUHP_AP_IRQ_MIPS_GIC_STARTING,
-	CPUHP_AP_IRQ_LOONGARCH_STARTING,
+	CPUHP_AP_IRQ_EIOINTC_STARTING,
 	CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
 	CPUHP_AP_IRQ_RISCV_IMSIC_STARTING,
 	CPUHP_AP_ARM_MVEBU_COHERENCY,
-- 
2.20.1


