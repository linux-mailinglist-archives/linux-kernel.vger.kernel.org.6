Return-Path: <linux-kernel+bounces-303749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3301D9614AF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 18:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0CA41F25A6B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D380C1D278E;
	Tue, 27 Aug 2024 16:53:59 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CB91CF29B
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 16:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724777639; cv=none; b=bBHFME3aDSF0V9H6vqOgLYSBFxqecMBofvU9GwBDrOJfZJgpPxuSLkbVkg45Yl+ojhYnpJ94bMvCAIKfaYUhrPKPirUxGjdWtE7ltYb7RPoBKUFJ9n7EDqgCMtlGX0/qWD1lr02tBc5J/ICPcbLPBidZ7eY/3Nmx16JV22TYwj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724777639; c=relaxed/simple;
	bh=mjQwnmTJTfm5oce9f5ZfHvkUuKmSrd5gyKWY/buXXJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Yp7PRmDi7vZzgGaQMWt1syrqlMMOEm4pl9LtOlY4j+N2aimz5n2Hh9fgfiY/1yBFDSB2Pkv5YxW0YbDuZ7Hpm9LaFOGzJftE1IHtTEONbe3ZXZG1DNFLsg2twG3foPeVrdlzE0RbjRp9f3D4BSF/SgbgtrSEBkEXAR50Vb+2Kt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WtYXf6vwlz9sRy;
	Tue, 27 Aug 2024 18:53:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jz3n189mu_bD; Tue, 27 Aug 2024 18:53:54 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WtYXf68pvz9sRs;
	Tue, 27 Aug 2024 18:53:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C4BBF8B78B;
	Tue, 27 Aug 2024 18:53:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 3mv2wfolewUL; Tue, 27 Aug 2024 18:53:54 +0200 (CEST)
Received: from [192.168.233.149] (unknown [192.168.233.149])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 900E08B77C;
	Tue, 27 Aug 2024 18:53:54 +0200 (CEST)
Message-ID: <ea693ce2-61dd-4885-805f-28aa7e60ea28@csgroup.eu>
Date: Tue, 27 Aug 2024 18:53:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] random: vDSO: move prototype of arch chacha function
 to vdso/getrandom.h
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org
References: <20240827151828.3326600-1-Jason@zx2c4.com>
 <20240827154822.3330270-1-Jason@zx2c4.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240827154822.3330270-1-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 27/08/2024 à 17:47, Jason A. Donenfeld a écrit :
> Having the prototype for __arch_chacha20_blocks_nostack in
> arch/x86/include/asm/vdso/getrandom.h meant that the prototype and large
> doc comment were cloned by every architecture, which has been causing
> unnecessary churn. Instead move it into include/vdso/getrandom.h, where
> it can be shared by all archs implementing it.
> 
> As a side bonus, this then lets us use that prototype in the
> vdso_test_chacha self test, to ensure that it matches the source, and
> indeed doing so turned up some inconsistencies, which are rectified
> here.

Side bonus that I dislike. Or ... it is all that u32 key stuff that I 
dislike.

If it was really u32 I would be able to read it with a LWZ instruction 
(Load Word Zero extended). That's what I did at the begining. But if I 
want the selftest to work, I have to use LWBRX (Load Word Byte Reversed 
...)instead  because the bytes in the word are in reversed order in reality.

So either it is a table of 32 bytes, or it is as defined in RFC 7539:

   A 256-bit key, treated as a concatenation of eight 32-bit 
little-endian integers.

And in that case it is not a table of 8x u32 but table of 8x __le32

> 
> Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---


> diff --git a/tools/testing/selftests/vDSO/vdso_test_chacha.c b/tools/testing/selftests/vDSO/vdso_test_chacha.c
> index e38f44e5f803..ca5639d02969 100644
> --- a/tools/testing/selftests/vDSO/vdso_test_chacha.c
> +++ b/tools/testing/selftests/vDSO/vdso_test_chacha.c
> @@ -7,16 +7,20 @@
>   #include <sys/random.h>
>   #include <string.h>
>   #include <stdint.h>
> +#include <stdbool.h>
>   #include "../kselftest.h"
>   
> -extern void __arch_chacha20_blocks_nostack(uint8_t *dst_bytes, const uint8_t *key, uint32_t *counter, size_t nblocks);
> +typedef uint8_t u8;
> +typedef uint32_t u32;
> +typedef uint64_t u64;
> +#include <vdso/getrandom.h>
>   
>   int main(int argc, char *argv[])
>   {
>   	enum { TRIALS = 1000, BLOCKS = 128, BLOCK_SIZE = 64 };
>   	static const uint8_t nonce[8] = { 0 };
>   	uint32_t counter[2];
> -	uint8_t key[32];
> +	uint32_t key[8];
>   	uint8_t output1[BLOCK_SIZE * BLOCKS], output2[BLOCK_SIZE * BLOCKS];
>   
>   	ksft_print_header();
> @@ -27,7 +31,7 @@ int main(int argc, char *argv[])
>   			printf("getrandom() failed!\n");
>   			return KSFT_SKIP;
>   		}
> -		crypto_stream_chacha20(output1, sizeof(output1), nonce, key);
> +		crypto_stream_chacha20(output1, sizeof(output1), nonce, (uint8_t *)key);
>   		for (unsigned int split = 0; split < BLOCKS; ++split) {
>   			memset(output2, 'X', sizeof(output2));
>   			memset(counter, 0, sizeof(counter));

