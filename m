Return-Path: <linux-kernel+bounces-372731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 403419A4C6B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 10:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E261B2276C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 08:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F2A1DED7E;
	Sat, 19 Oct 2024 08:56:38 +0000 (UTC)
Received: from zg8tmtu5ljy1ljeznc42.icoremail.net (zg8tmtu5ljy1ljeznc42.icoremail.net [159.65.134.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD841DE888;
	Sat, 19 Oct 2024 08:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.65.134.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729328197; cv=none; b=JZJklHK1FQhAbbRspdvC9OXGv9yLsEaqvggCJ2N7Jg5b6p1KnwU4jDkqPMERY9UYQFbMr95vlAdeOdDvKVO4gHPGbAfAtOdkRXG4s93Gj+xGXoidCVOont49BxjyinUqRCugUeqwSvm8wKaKalO8qi9FSO69KTPftPK4czS9xkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729328197; c=relaxed/simple;
	bh=N/wSuX5vcPIyhrsFlGIFS+1AEuqMTVfVFTPVwZDTa1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U2xmhfHEqGj/QkujXaoDJfBmuc6V78fwc2sqUM7cKKM3vwcc69nCB4m0hVPWwPLbkqReyGTY8yRMQFCu2xK93oSxxBP5kfNbPxMPfG/Fxs6fkaVecdGsxKkxwZyjWBv0EM+6JT6s/zV6wYbYmJ0ZVmMv0/uEaLavZMpq62FYA3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=159.65.134.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app1 (Coremail) with SMTP id HgEQrADHzn4VdBNnW44fCA--.54170S2;
	Sat, 19 Oct 2024 16:55:49 +0800 (CST)
Received: from pride-PowerEdge-R740.. (unknown [222.20.126.129])
	by gateway (Coremail) with SMTP id _____wAH8UIMdBNnstxuAA--.62062S3;
	Sat, 19 Oct 2024 16:55:48 +0800 (CST)
From: Dongliang Mu <dzm91@hust.edu.cn>
To: si.yanteng@linux.dev,
	alexs@kernel.org,
	corbet@lwn.net,
	Yanteng Si <siyanteng@loongson.cn>,
	Dongliang Mu <dzm91@hust.edu.cn>
Cc: hust-os-kernel-patches@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] docs/zh_CN: update the translation of mm/active_mm.rst
Date: Sat, 19 Oct 2024 16:54:52 +0800
Message-ID: <985f62236dad7c9446272d94bffc20eb8f45ae4b.1729327831.git.dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729327831.git.dzm91@hust.edu.cn>
References: <cover.1729327831.git.dzm91@hust.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HgEQrADHzn4VdBNnW44fCA--.54170S2
Authentication-Results: app1; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrWfCF47AFW7Gr18Xr17Awb_yoW8GFWUpF
	1UKrWfK3WIyw13KrWIgw4DW3WrGFsxGa15Kr1UXw1FqF15Ca1vvayak3s8KF97X3yfZFWU
	C3yfurW3GFy5Aw7anT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQab7Iv0xC_Cr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vE
	x4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAaw2AFwI0_JF
	0_Jw1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF
	0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26r
	4UJVWxJr1lYx0E74AGY7Cv6cx26r4fZr1UJr1lYx0Ec7CjxVAajcxG14v26r4UJVWxJr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMx
	AIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GFW3Jr1UJwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwCFI7km07C267AKxVWUtVW8ZwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jfvtZUUUUU=
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/

Update to commit 88e3009b5283 ("lazy tlb: allow lazy tlb
mm refcounting to be configurable")

scripts/checktransupdate.py reports:

Documentation/translations/zh_CN/mm/active_mm.rst
commit 88e3009b5283 ("lazy tlb: allow lazy tlb mm refcounting
to be configurable")
commit ee86588960e2 ("docs/mm: remove useless markup")
2 commits needs resolving in total

Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 Documentation/translations/zh_CN/mm/active_mm.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/translations/zh_CN/mm/active_mm.rst b/Documentation/translations/zh_CN/mm/active_mm.rst
index c2816f523bd7..b3352668c4c8 100644
--- a/Documentation/translations/zh_CN/mm/active_mm.rst
+++ b/Documentation/translations/zh_CN/mm/active_mm.rst
@@ -13,6 +13,11 @@
 Active MM
 =========
 
+注意，在配置了 CONFIG_MMU_LAZY_TLB_REFCOUNT=n 的内核中，mm_count 引用计数
+可能不再包括“懒惰”用户（运行任务中 ->active_mm == mm && ->mm == NULL）。
+获取和释放这些懒惰引用必须使用 mmgrab_lazy_tlb() 和 mmdrop_lazy_tlb() 这
+两个辅助函数，它们抽象了这个配置选项。
+
 这是一封linux之父回复开发者的一封邮件，所以翻译时我尽量保持邮件格式的完整。
 
 ::
-- 
2.43.0


