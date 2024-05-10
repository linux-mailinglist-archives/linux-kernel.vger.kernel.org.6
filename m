Return-Path: <linux-kernel+bounces-175811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C638C2567
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 15:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD6282857FB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 13:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623CF129A8D;
	Fri, 10 May 2024 13:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="nEg406pV"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27A5537E8;
	Fri, 10 May 2024 13:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715346610; cv=none; b=DPLzM+7hD+Za+Rni2IW/rUcaZgDkSbfmdW0MZ8O/NrBIjiscG2i23+F/5TWi65oLULLa4XO8CzW3z0s5D9uhcMng7eGYyT9bWUSPADMdtYzT8QRKj0fe7ordBZMgr6iMK7hVCRmVDXnjprZZWh7/GurFi/cYbzpaxjgwUMpuSo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715346610; c=relaxed/simple;
	bh=TEjOAr2RBcw1JCUNuulbRKnV4fRzOVevxCBZSShKBfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fS+MFTrzfiWiAZrHsxZGUFR5Vew8Riq9458bmdymfGH8/pfSd023LwINnxmhu8gX0gMNPr/7x3L+8b7tE4DzC/vJzhGHiok/kC8YySxojVHZTkfewV/eVsew1MzqGzebGCP1Arv41rQZ3bfI/Ftl36SRVVbyx4t9qrZSjkP1MU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=nEg406pV; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1715346602; x=1715951402; i=deller@gmx.de;
	bh=TfThBHnieEcrMXwxApoo4pCodB7Hvz/a15x0aREPaOg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=nEg406pVK+/SHrLvqGDyBOUokAajlV1nPrh+Kb3ew/2NV0nzoglpCYo/u+9cdWdz
	 kqRYRrr+fSsbRGdBAEwqvSLm4jCcn3ftc6QAyqEbbKLQOSsaSIHBQZXXNIuoaFfpn
	 IOEGye/evLUu1exc0Zd/+AP+UOBlEQ28HgIH/TAZrffQZORYnEpFZHPnJHjHrIwx+
	 FA00m8XNgvJhEoR/eHEjMy+FXOAti0ulEQcg1zDK3qIM2BYXS477LP/IsoAaCQEzM
	 piB8yWIjKd2iznMdnwpRj+wR5QbvuJ3fsNu3QISuyVEch7Qlm1TvmfKZ9xZfvIT87
	 /4a1fMfJtjwDbYxtgQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([89.244.191.219]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Ml6mE-1sSfvq2XXw-00iGAu; Fri, 10
 May 2024 15:10:02 +0200
Message-ID: <d2da3581-7ca8-409d-97f1-6d3a19adc3c4@gmx.de>
Date: Fri, 10 May 2024 15:10:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] parisc/math-emu: Remove unused struct 'exc_reg'
To: linux@treblig.org, James.Bottomley@HansenPartnership.com
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240505231059.680502-1-linux@treblig.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240505231059.680502-1-linux@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jcVzNKRtFAfAV0vdl20vebHyWvs1WK+UeixILDbjxPPrq88xOZp
 h8441K8u3axZlqa/AeQeGmlv31D0pzn6XeoT7SHaNVIGE3iLUgnzg2MFd13JUP6YQyNxCKL
 h027ULpIXTpVVTxTEjUDrxJl4QZHCrFcU8VwnTqUR2O7sAI1zqSaY7XUEVYQ6c58hC4SmCL
 dBfmaQ7gVrJmrEYxTG+YA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bZ/gyKCu+d0=;fZneFa1EwKk+aeT3ouemToxEtSM
 AGrmXipEM9EkmBNMdrkHHadUh4n3xsDpXk6Q71pHh9roVec+9KGV+GNCWJqt6kuf1leopfspi
 flQiNJTLEErGdQ3FH6aIs8kJneYXH2pTwqD+WCkkuk5BsqRXf+3PBINGRfsb0MyURqNQQ7xFB
 Jp0xy5rv4Ajb07FGcr875EO2CMRqLb81qvgbHTjMuBzxmsxTpsq1UUvaOeMmwGku12tbI7C9W
 yeOgb7AvQjfJbwWWG+CJBR63RkfoogQW1iy5BpURNfpTvntUNNeLwegtZmVkBEkA9BxT7cgTF
 uJwMAmnUeRQ3nF0ZQRIIQdVl7BgFyA60cZFWoAeC1ls7+axFH6zJBwCF8IMwVLRC9yxG16FVD
 e7v/5kgIU3lb92uty6AfABAuS81FBhcGSnWExRG58Bd2XHRmn0qLiJciPNRVqsIMfMkNvyij/
 0qO9bcUOATUaGKnN5c63AZRfcehgxUHD4Q6G5WODlXXQH0tysTaBIBVAyNObx1y+yPMIVg3nv
 PZwDCZdBFlbVXCsKUelMBNFAbqWtYWm0jGyIae4I5Bclpl6VbCMP8DhU6R9vK02hMUYa/YA8V
 ImOV1AI448JLqHdqji69qfvEkmmi8mRHV3Qa02tk9FcYBLCJLb00oXVtNiF7x5FU2wkgvvZa2
 MOfMRR/oBsNwOXHX/FNWYcAgHkuCK4XzUTLdb5XF0CL7ORuMyDPEQE/l0tKVrVpeZXo2mNI/4
 N2pDpfeMpav2Ewia119XkjNxpePi2q8YjUeBRPR2VpXCvInHckvanldpBsVcjqmiHHD7p9B+L
 8gPE26sRyFAMkLosU9ZXsMHmDC0NxS5nLe6Ng+oj6/0Q0=

On 5/6/24 01:10, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> This has been here since pre-git.
>
> Build tested.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

applied.
Thanks!
Helge

> ---
>   arch/parisc/math-emu/driver.c | 6 ------
>   1 file changed, 6 deletions(-)
>
> diff --git a/arch/parisc/math-emu/driver.c b/arch/parisc/math-emu/driver=
c
> index 6ce427b58836c..34495446e051c 100644
> --- a/arch/parisc/math-emu/driver.c
> +++ b/arch/parisc/math-emu/driver.c
> @@ -26,12 +26,6 @@
>
>   #define FPUDEBUG 0
>
> -/* Format of the floating-point exception registers. */
> -struct exc_reg {
> -	unsigned int exception : 6;
> -	unsigned int ei : 26;
> -};
> -
>   /* Macros for grabbing bits of the instruction format from the 'ei'
>      field above. */
>   /* Major opcode 0c and 0e */


