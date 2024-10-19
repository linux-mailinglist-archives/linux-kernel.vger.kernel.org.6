Return-Path: <linux-kernel+bounces-372732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4229A4C6D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 10:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3F45283216
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 08:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182451DFD80;
	Sat, 19 Oct 2024 08:56:39 +0000 (UTC)
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D211DE88E;
	Sat, 19 Oct 2024 08:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729328198; cv=none; b=lNqBdXG9BZuYmn/9sCvrdaJOydktMn5w/z9bLzE69SVBOfDxn8kX7FAr0ZmZh8tZDl/dfeNda41+AbjKGQ6oWObwws+XW74HIJ/Y0CKgEfmmnImjPZ+NvFhEp8CZ8tJ9I9jfS/qUqdZAUOXUOJR4O+xW2pTjBT+8UUPc4AZj6kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729328198; c=relaxed/simple;
	bh=1KTsm1FbxTkZygRnRaYqVZdq3K2ggDGiBp0zQ52nPsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qQI50/gmOqAudGhhjnFud7rqUKH8EyZ0y4iS0/UvceJr2mxSIn/HMG4zjmgW9/tJbCCN6GqdW1VPLgiYG/DmU0zvxqJTxi1Gf+s0AqytfvTEqXj9hVP8LZSONqK/9QiAltxZcbYjPYy5fczcgsSpm0X4338ZlS5J7yW6Ayo8Hsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app1 (Coremail) with SMTP id HgEQrADHzzsNdBNnDI4fCA--.49092S2;
	Sat, 19 Oct 2024 16:55:41 +0800 (CST)
Received: from pride-PowerEdge-R740.. (unknown [222.20.126.129])
	by gateway (Coremail) with SMTP id _____wAH8UIMdBNnstxuAA--.62062S2;
	Sat, 19 Oct 2024 16:55:40 +0800 (CST)
From: Dongliang Mu <dzm91@hust.edu.cn>
To: si.yanteng@linux.dev,
	alexs@kernel.org,
	corbet@lwn.net,
	Yanteng Si <siyanteng@loongson.cn>,
	Dongliang Mu <dzm91@hust.edu.cn>
Cc: hust-os-kernel-patches@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] docs/zh_CN: update the translation of mm/hmm.rst
Date: Sat, 19 Oct 2024 16:54:51 +0800
Message-ID: <82259a2656549c90591dc3873f3d2e8a4fb41233.1729327831.git.dzm91@hust.edu.cn>
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
X-CM-TRANSID:HgEQrADHzzsNdBNnDI4fCA--.49092S2
Authentication-Results: app1; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoW7KF1ktrWDZFWkur43tr45trb_yoW8CFyfpF
	97KrWxKa17t345Kr4xGF17Za18u3WIgayxJryxXan2qrn8ta97t398trWFgasxX3ykZFW5
	ZanxKrWfZ34FywUanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQab7Iv0xC_Cr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vE
	x4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAaw2AFwI0_JF
	0_Jw1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF
	0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26r
	4UJVWxJr1lYx0E74AGY7Cv6cx26r4fZr1UJr1lYx0Ec7CjxVAajcxG14v26r4UJVWxJr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMx
	AIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GFW3Jr1UJwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jfvtZUUUUU=
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/

Update to commit 406c4c5ee4ea ("docs:mm: fix spelling mistakes in
heterogeneous memory management page")

scripts/checktransupdate.py reports:

Documentation/translations/zh_CN/mm/hmm.rst
commit 406c4c5ee4ea ("docs:mm: fix spelling mistakes in heterogeneous
memory management page")
commit 090a7f1009b8 ("docs/mm: remove references to hmm_mirror ops and
clean typos")
commit d56b699d76d1 ("Documentation: Fix typos")
3 commits needs resolving in total

Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 Documentation/translations/zh_CN/mm/hmm.rst | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/Documentation/translations/zh_CN/mm/hmm.rst b/Documentation/translations/zh_CN/mm/hmm.rst
index babbbe756c0f..0669f947d0bc 100644
--- a/Documentation/translations/zh_CN/mm/hmm.rst
+++ b/Documentation/translations/zh_CN/mm/hmm.rst
@@ -129,13 +129,7 @@ struct page可以与现有的 mm 机制进行最简单、最干净的集成。
   int hmm_range_fault(struct hmm_range *range);
 
 如果请求写访问，它将在丢失或只读条目上触发缺页异常（见下文）。缺页异常使用通用的 mm 缺
-页异常代码路径，就像 CPU 缺页异常一样。
-
-这两个函数都将 CPU 页表条目复制到它们的 pfns 数组参数中。该数组中的每个条目对应于虚拟
-范围中的一个地址。HMM 提供了一组标志来帮助驱动程序识别特殊的 CPU 页表项。
-
-在 sync_cpu_device_pagetables() 回调中锁定是驱动程序必须尊重的最重要的方面，以保
-持事物正确同步。使用模式是::
+页异常代码路径，就像 CPU 缺页异常一样。使用模式是::
 
  int driver_populate_range(...)
  {
-- 
2.43.0


