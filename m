Return-Path: <linux-kernel+bounces-211708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1F89055C7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8724E286701
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E622617F4F8;
	Wed, 12 Jun 2024 14:52:44 +0000 (UTC)
Received: from hust.edu.cn (unknown [202.114.0.240])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FE217F374;
	Wed, 12 Jun 2024 14:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.114.0.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718203964; cv=none; b=jBHaX8ktCvZlpWFOTuE02up2q4DNjZwNGzCpBOOSH811DOINosH1tbdW5h6/lLCO/sSKDKfRd56Y52ctSgZEyTTBcIjfZ2P43MhjNVmywWek1N2qnTM9tO1WIXir/452eJA2OgoAMq66PThrgQo/WFe24eRtkEO3yRazd8fligQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718203964; c=relaxed/simple;
	bh=kicZ9/XRu1MAmkWk/I+JRxn8BvTZI+30+zPvFIqGN2I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Sk8BYQp5UnHreVfyoPR/tSs01u4IX2viS4TykiI5kQDrWOS9JgE/kNnMhNmGmuBTGjVrVc3U+Z+BMlvY3zGpSYuPTKFTw+OtTuQEw7/lGcDSSieo3aTecEmYqTee8RkYsom/lwYOtFU3qYE3mDBmGH/U0WakzXVJoxBi/cQUNe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=202.114.0.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app2 (Coremail) with SMTP id HwEQrABHn8cCtmlm6cxvAQ--.12262S2;
	Wed, 12 Jun 2024 22:51:46 +0800 (CST)
Received: from pride-poweredge-r740.. (unknown [222.20.126.129])
	by gateway (Coremail) with SMTP id _____wDn7sYBtmlmLq4KAQ--.11539S2;
	Wed, 12 Jun 2024 22:51:46 +0800 (CST)
From: Dongliang Mu <dzm91@hust.edu.cn>
To: Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Jonathan Corbet <corbet@lwn.net>,
	Dongliang Mu <dzm91@hust.edu.cn>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs/zh_CN: Update the translation of dev-tools/gdb-kernel-debugging
Date: Wed, 12 Jun 2024 22:50:45 +0800
Message-Id: <20240612145048.57829-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HwEQrABHn8cCtmlm6cxvAQ--.12262S2
Authentication-Results: app2; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww1rGr48ZF48ZF15ur1DAwb_yoW8JFyxpw
	4q9FyfG3WfZry3J345GF48GFy7Jas7GF45KFy0va4Fqryvq3yIqw4akas0qFy2q34IyFWU
	uF4fCFyj93y093JanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm2b7Iv0xC_Cr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vE
	x4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAaw2AFwI0_Jr
	v_JF1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF
	0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26r
	4UJVWxJr1lYx0E74AGY7Cv6cx26r4fZr1UJr1lYx0Ec7CjxVAajcxG14v26r4UJVWxJr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxAIw2
	8IcVCjz48v1sIEY20_GFW3Jr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AK
	xVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
	xhVjvjDU0xZFpf9x07jfpndUUUUU=
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/

Update to commit 6b219431037b ("docs/scripts/gdb: add necessary
make scripts_gdb step")

Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 .../translations/zh_CN/dev-tools/gdb-kernel-debugging.rst     | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/translations/zh_CN/dev-tools/gdb-kernel-debugging.rst b/Documentation/translations/zh_CN/dev-tools/gdb-kernel-debugging.rst
index 17b5ce85a90c..94c15c258726 100644
--- a/Documentation/translations/zh_CN/dev-tools/gdb-kernel-debugging.rst
+++ b/Documentation/translations/zh_CN/dev-tools/gdb-kernel-debugging.rst
@@ -34,6 +34,10 @@ Kgdb内核调试器、QEMU等虚拟机管理程序或基于JTAG的硬件接口
   但这通常仅在不依赖内核模块时才有效。有关此模式的更多详细信息，请参阅QEMU文档。
   在这种情况下，如果架构支持KASLR，应该在禁用CONFIG_RANDOMIZE_BASE的情况下构建内核。
 
+- 构建gdb脚本（适用于内核v5.1版本及以上）
+
+    make scripts_gdb 
+
 - 启用QEMU/KVM的gdb stub，可以通过如下方式实现
 
     - 在VM启动时，通过在QEMU命令行中添加“-s”参数
-- 
2.34.1


