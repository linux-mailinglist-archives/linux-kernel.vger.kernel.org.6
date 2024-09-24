Return-Path: <linux-kernel+bounces-337568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5336B984BC4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 21:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7D12B22420
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 19:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A22684E11;
	Tue, 24 Sep 2024 19:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="bkknMWkU"
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D6713A884
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 19:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727207171; cv=none; b=Vqg/zUqVlVwpVgfi+miSp3W+pB5H93iBpKGgsHCoJiW2hoyJAwTP9G65nDEQ18tgWhGPVkqykuC0Z5WodEcymDOcNRQPRSFaGgt/9CIWaFNDtWZzlkli2vz2dQ2xLnQIVvb4BJZfwG17zFrAr/J1zguzB2FUVZDPzUfmV0vBbso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727207171; c=relaxed/simple;
	bh=s3lwkkcgIHvC0MY40Kp6u2Ptl8oqQHAFTArUzvnNW28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fx1ywJcTAW7HODpq36qirvpcLqaQfwu+p4xj+IG8NYGpBqElSLodFRHQ8qHWSySCu3E/BalvOg4rpe/GptopCsUPB8VmVVfvcAHAVy2KwTqi0aaSxQmkMGf83CS6WtEgGWFpR7tbAWNy4oYpQGmVvOE5kaq6cWumF8zP/s5j8lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=bkknMWkU; arc=none smtp.client-ip=80.12.242.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id tBTzsVA7RO2lmtBTzsaLou; Tue, 24 Sep 2024 21:46:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1727207161;
	bh=TVUQYXiQsfKBwm1bsadNvnge0M4C6PEwh0rK1nOokCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=bkknMWkUG1mR22GldXTwvFx3us4GNWeV/uslbEYEasDG1ULcXRiG8ioYSmyfQvHFB
	 ijQC6XZRJyDsPdjCgt9817/PnknNXUob/ucU5jL8hOiX8dlFCbjHD/qvEnaPIVpPLN
	 5N/sfuxKmf//jpkBRbS0VgVvzMesOMVS89TDUWIshncjBJpwqPnkpzk7T4OZFAqsvv
	 khmIB8u6UIk7awUmL87OUtrqBvrKK1H6HLp6IN25Vjdcuuz9HKVgFbFX4sZQFSnbY8
	 it3Z7k4G19SHQfnHYnenXy5IreOJK3iaPDcDGc+5IPm8zI2T152pB6s9EEvGBZfJya
	 VqyRHAbhxjjQA==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Tue, 24 Sep 2024 21:46:01 +0200
X-ME-IP: 90.11.132.44
Message-ID: <67060a27-5830-4ea1-955f-722f1d2c83b4@wanadoo.fr>
Date: Tue, 24 Sep 2024 21:45:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] mm: do not export const kfree and kstrdup variants
To: Christoph Hellwig <hch@infradead.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Andrey Skvortsov <andrej.skvortzov@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240924050937.697118-1-senozhatsky@chromium.org>
 <ZvJfhDrv-eArtU8Y@infradead.org> <20240924065653.GQ38742@google.com>
 <ZvJkC_3cov1rfY0V@infradead.org>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <ZvJkC_3cov1rfY0V@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 24/09/2024 à 09:02, Christoph Hellwig a écrit :
> On Tue, Sep 24, 2024 at 03:56:53PM +0900, Sergey Senozhatsky wrote:
>> Totally agree with all the points, I haven't looked at how
>> popular that API was before sending out the patch.  Is there
>> some sort of "built time const" but for strings that we, perhaps,
>> can add to kfree_const() (and make kfree_const() always inline)?
>> So that we can turn this
>>
>> 	str = "boom";
>> 	...
>> 	kfree_const(str);
>>
>> into a safe scenario for modules.
> 
> Not sure, but even then the API would be horrible as it still would
> not work for constants in other modules than the one calling it.
> 
> 

So, the best is to audit, at least code that can be built as a module 
for str = "boom" pattern, and fix relevant places?


Or, considering that these these _const() versions are only there to 
save a few bytes of memory, wonder if it really worth it?

In other word:
	1) apply something like the patch below
	2) remove the API


At a minimum, I think that devm_kstrdup_const() could be removed.

CJ


diff --git a/mm/util.c b/mm/util.c
index 4f1275023eb7..fd5e98fb6362 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -39,8 +39,7 @@
   */
  void kfree_const(const void *x)
  {
-       if (!is_kernel_rodata((unsigned long)x))
-               kfree(x);
+       kfree(x);
  }
  EXPORT_SYMBOL(kfree_const);

@@ -81,9 +80,6 @@ EXPORT_SYMBOL(kstrdup);
   */
  const char *kstrdup_const(const char *s, gfp_t gfp)
  {
-       if (is_kernel_rodata((unsigned long)s))
-               return s;
-
         return kstrdup(s, gfp);
  }
  EXPORT_SYMBOL(kstrdup_const);



