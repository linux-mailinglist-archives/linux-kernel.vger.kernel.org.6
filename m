Return-Path: <linux-kernel+bounces-372730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF279A4C6A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 10:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F2DD2830A0
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 08:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F26E1DED71;
	Sat, 19 Oct 2024 08:56:38 +0000 (UTC)
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D6D1DE88D;
	Sat, 19 Oct 2024 08:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729328197; cv=none; b=IHT2Ja0Nr5+A8zGZ/nRLZ8QuxtBMIKzSvR2vZpwxeYVQ5H+KAQhEHrtTMOVlGpEKPgfwGEzCW1fMacjbZ0dpR3EMOkYNqD7vE5mGoJ1y2+88VgUxV1yDf6tZCSXFz2jC0GJ9Lazz1drVVmVcvrk07g5iJQko+St5e2GyHDwKU+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729328197; c=relaxed/simple;
	bh=dnP/VKNFhb11EHXf4zlGj1blKoCjFEjjxiIExDwcPEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G2JxBB5JLmwu3tIRIUkwO2jO7Jp2mbPjEEQ/B1jwc7SHErPnT7Ns0UpjY1XVBRVULy3o/6wGa5IUMN159rN/7JSe9j718FflyxOIrYJLk0RbwwLRplQocBfUosht5UA/EFan6oozVdDj+MgOR+gFIYFhS+340va/5MUgbN0wKHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app1 (Coremail) with SMTP id HgEQrADXGqQidBNnOI8fCA--.43861S2;
	Sat, 19 Oct 2024 16:56:02 +0800 (CST)
Received: from pride-PowerEdge-R740.. (unknown [222.20.126.129])
	by gateway (Coremail) with SMTP id _____wAH8UIMdBNnstxuAA--.62062S5;
	Sat, 19 Oct 2024 16:56:01 +0800 (CST)
From: Dongliang Mu <dzm91@hust.edu.cn>
To: si.yanteng@linux.dev,
	alexs@kernel.org,
	corbet@lwn.net,
	Yanteng Si <siyanteng@loongson.cn>,
	Dongliang Mu <dzm91@hust.edu.cn>
Cc: hust-os-kernel-patches@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] docs/zh_CN: update the translation of mm/overcommit-accounting.rst
Date: Sat, 19 Oct 2024 16:54:54 +0800
Message-ID: <d426f3f3d9aac061c20c3b766c17369f4e60f398.1729327831.git.dzm91@hust.edu.cn>
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
X-CM-TRANSID:HgEQrADXGqQidBNnOI8fCA--.43861S2
Authentication-Results: app1; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoW7KFyfZF4DJFy7AF45tFWkWFg_yoW8WF1Upa
	4Ikwn7Wa1FyF1rGryUGw18Xay8AFsrCa9xGFW2qa4aqr4rJa1kKrZFkw1ag3W3XryxJF98
	XFWIgayrZry0kr7anT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQab7Iv0xC_Ar1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vE
	x4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAaw2AFwI0_JF
	0_Jw1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF
	0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26r
	4UJVWxJr1lYx0E74AGY7Cv6cx26r4fZr1UJr1lYx0Ec7CjxVAajcxG14v26r4UJVWxJr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMx
	AIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GFW3Jr1UJwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwCFI7km07C267AKxVW8ZVWrXwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0zRuVbgUUUUU=
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/

Update to commit d17ff438a036 ("docs: mm: fix vm overcommit
documentation for OVERCOMMIT_GUESS")

scripts/checktransupdate.py reports:

Documentation/translations/zh_CN/mm/overcommit-accounting.rst
commit d17ff438a036 ("docs: mm: fix vm overcommit documentation
for OVERCOMMIT_GUESS")
1 commits needs resolving in total

Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 Documentation/translations/zh_CN/mm/overcommit-accounting.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/translations/zh_CN/mm/overcommit-accounting.rst b/Documentation/translations/zh_CN/mm/overcommit-accounting.rst
index d8452d8b7fbb..f136a8b81859 100644
--- a/Documentation/translations/zh_CN/mm/overcommit-accounting.rst
+++ b/Documentation/translations/zh_CN/mm/overcommit-accounting.rst
@@ -16,8 +16,7 @@ Linux内核支持下列超量使用处理模式
 
 0
 	启发式超量使用处理。拒绝明显的地址空间超量使用。用于一个典型的系统。
-	它确保严重的疯狂分配失败，同时允许超量使用以减少swap的使用。在这种模式下，
-	允许root分配稍多的内存。这是默认的。
+	它确保严重的疯狂分配失败，同时允许超量使用以减少swap的使用。这是默认的。
 1
 	总是超量使用。适用于一些科学应用。经典的例子是使用稀疏数组的代码，只是依赖
 	几乎完全由零页组成的虚拟内存
-- 
2.43.0


