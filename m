Return-Path: <linux-kernel+bounces-263125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A01993D157
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 12:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9BA228141B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 10:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C5917838C;
	Fri, 26 Jul 2024 10:46:52 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4550C7F8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 10:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721990812; cv=none; b=RAuei290WETmDy8WOijnxCq+whrq97blJt5K6xIjBVdgFkJVNEIKTPmdUjcDM8H9YRHW52TdTcSNRYiMdO8PTCqbcPW0vRRQJh/yWizUezPsg81oSdgkAUD6aSSdBdCbSliPCrXh3eB8C97Uiiu+XGrnniCchcfgwSkcq0y2zAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721990812; c=relaxed/simple;
	bh=LEXtchw25jKSI/e0hbHQsFmZjxoeFZikXMTdGqS5qn4=;
	h=From:Subject:To:Cc:Message-ID:Date:MIME-Version:Content-Type; b=gaTZD+0S7X4Wws2wIWaNmZc3t5h3RYXM1asmENqOgqJ0/aQmCtH1pi110OY9N8aKGXRrFEIRQ1LD3Gy+r5kV6o8OwVgRreZ7JkWRqGBrX1hQQGgDqjunKyjs1JvkwgRfILG243H2IT5V72Rl62D4sPpKWwTuYX7Zy/WVhrjnN7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxyOmUfqNm+QsCAA--.7586S3;
	Fri, 26 Jul 2024 18:46:44 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMCxPseOfqNmCqUCAA--.15131S3;
	Fri, 26 Jul 2024 18:46:38 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Question about patch "bug.h: work around GCC PR82365 in BUG()"
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
Message-ID: <e54d8849-c920-a5c5-aac4-83870ee5ecb7@loongson.cn>
Date: Fri, 26 Jul 2024 18:46:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowMCxPseOfqNmCqUCAA--.15131S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7Jr1UKF17Gw1xCFW7uF47WrX_yoWfCrg_A3
	WDAwnrG3s8Wr4kAF42qFWUZF93t3ykA34DXrWfGwnrAryrJayqqF95ury7uws3A395Jr1D
	Cw4rXFyfZF1UZosvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbI8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
	AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUrNtx
	DUUUU

Hi Arnd,

In the commit 173a3efd3edb "bug.h: work around GCC PR82365 in BUG()",
an empty inline assembly was added to work around GCC 7.0, I want to
know what is the status of this GCC bug, is it fixed or not?

If the GCC bug has been fixed, could you please tell me what is the
commit id of GCC? I can not find it in the bug link:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82365

The default CONFIG_FRAME_WARN is 2048 on 64 bit system, I am not sure
whether it is time and proper to remove this workaround in the common
header include/linux/compiler-gcc.h totally, at least I want to remove
it in the arch specified header when compiling kernel with a newer GCC
version (for example GCC 12.1 or higher on LoongArch), something like
this:

+#ifdef barrier_before_unreachable
+#undef barrier_before_unreachable
+#define barrier_before_unreachable() do { } while (0)
+#endif

Thanks,
Tiezhu


