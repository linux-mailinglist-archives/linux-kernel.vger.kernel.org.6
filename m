Return-Path: <linux-kernel+bounces-249700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDB992EEB4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 20:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2011F1F21FD2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D593B16DECB;
	Thu, 11 Jul 2024 18:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="u4IMIUbP"
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92AA16D9CD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 18:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720721994; cv=none; b=Sl0aml1e2oSY9CvnGyIiakF3EOa+q7E7S7PrqaGAW6hhMIqvyrimYECPShzOPgGjvD+ve/LiTZFLwKiZURnXdtbMuSWHLsZdJ8h+1hSR+exFbZR85MmBGeRYF1PLxWO+GysxbLJuMXW4Bs64TrmjIS0Vb9pjtKP1u9DbQIH+IaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720721994; c=relaxed/simple;
	bh=VyJlcToMzx0LCINy0+uJWpolFnNw4aIb6nYGbE5ueCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tinBSmilaSWe7peo6c1X2/nhh0MlWjAyL7rFgJAo9tRVPc75HI03p2QR3G2WGsSxiY3Tl0Pq+sLPMebc67CIHnbbjeKuV9FM4ki1v+0Zq/Tgei9EDSeeNxHciTtQBC59mQb0owZuGGIYFUFsFlXmvu9OYTRaNN5i6MF7XbGCxUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=u4IMIUbP; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5010a.ext.cloudfilter.net ([10.0.29.199])
	by cmsmtp with ESMTPS
	id RtP5s8K6QVpzpRyOWsapSN; Thu, 11 Jul 2024 18:19:52 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id RyOVsoM36vtoqRyOVs106a; Thu, 11 Jul 2024 18:19:51 +0000
X-Authority-Analysis: v=2.4 cv=Ffcxxo+6 c=1 sm=1 tr=0 ts=66902247
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=Q-fNiiVtAAAA:8 a=aq3Cxmdmga5VZ6caJNIA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=Fp8MccfUoT0GBdDC_Lng:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=d2Jmflu5nudn962vuPToAaUdux6l93VZQyfYfG0Szu4=; b=u4IMIUbPOI9t9d0Sw5kcQCxavT
	/z0/MAe79wOBuhqjjb+/h9gmmkEdpjXbca1p7jz2DtnPTLASE8ajywfiDugYXVAqgBBzjAEAvrg/p
	WbVpGHr1aeJa27gAREp7OJ+xn2sBZxOm5quZGQ3MKFnnVQxJF+avMCJ4UbV1xjPTzxy9F2ppWDtaW
	Ib2Zd8bdObJh6tQLvvJWKtKcXPYv8hoYdAeHAD/sM5vKOpeghdpitfItbInSSVve776CtmX7LiCvB
	fHBG9uwMRKGNOh++pJ57S89DGk/gWsYOZgAQMyxtpvRPAPTQsaJZr7E9sIo7n5zcdWP1oQJi1DBPt
	3cYo7WYw==;
Received: from [201.172.173.139] (port=35998 helo=[192.168.15.4])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sRyOU-002NJ6-1u;
	Thu, 11 Jul 2024 13:19:50 -0500
Message-ID: <382327b5-780e-4d04-8901-a7dae0ca6a2f@embeddedor.com>
Date: Thu, 11 Jul 2024 12:19:49 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] scsi: message: fusion: struct _CONFIG_PAGE_IOC_4:
 Replace 1-element array with flexible array
To: Kees Cook <kees@kernel.org>, Sathya Prakash <sathya.prakash@broadcom.com>
Cc: Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
 Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240711172432.work.523-kees@kernel.org>
 <20240711172821.123936-6-kees@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240711172821.123936-6-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.139
X-Source-L: No
X-Exim-ID: 1sRyOU-002NJ6-1u
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.4]) [201.172.173.139]:35998
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 61
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJaaf2J62DfAk37AnNix50fLL+gSBtySHu9Kek/nMB27IgiLx7opmxvuYasK9taF5/7dUB9+MPiHpbliM1DYTMDOJlEBII/e4rmntLd5nVfIGhe40X2P
 qhBTuOnLAOGMqi8vjEiJRSW5vJjGC0UQ171oyOnsrELSbU7A/fBwfKuQb+IjNzaOlhDjub9uKTUFM1NmK6ejFAOraCY+2ecE4pPOYN0MM9Clpcu2Jo8035b4



On 11/07/24 11:28, Kees Cook wrote:
> Replace the deprecated[1] use of a 1-element array in
> struct _CONFIG_PAGE_IOC_4 with a modern flexible array.
> 
> Additionally add __counted_by annotation since SEP is only ever accessed
> after updating ACtiveSEP:
> 
> lsi/mpi_cnfg.h:    IOC_4_SEP                   SEP[] __counted_by(ActiveSEP);  /* 08h */
> mptsas.c:        ii = IOCPage4Ptr->ActiveSEP++;
> mptsas.c:        IOCPage4Ptr->SEP[ii].SEPTargetID = id;
> mptsas.c:        IOCPage4Ptr->SEP[ii].SEPBus = channel;
> 
> No binary differences are present after this conversion.
> 
> Link: https://github.com/KSPP/linux/issues/79 [1]
> Signed-off-by: Kees Cook <kees@kernel.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-- 
Gustavo

> ---
> Cc: Sathya Prakash <sathya.prakash@broadcom.com>
> Cc: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
> Cc: Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: MPT-FusionLinux.pdl@broadcom.com
> Cc: linux-scsi@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org
> ---
>   drivers/message/fusion/lsi/mpi_cnfg.h | 10 +---------
>   1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/message/fusion/lsi/mpi_cnfg.h b/drivers/message/fusion/lsi/mpi_cnfg.h
> index bac49c162165..1167a16d8fb4 100644
> --- a/drivers/message/fusion/lsi/mpi_cnfg.h
> +++ b/drivers/message/fusion/lsi/mpi_cnfg.h
> @@ -1077,21 +1077,13 @@ typedef struct _IOC_4_SEP
>   } IOC_4_SEP, MPI_POINTER PTR_IOC_4_SEP,
>     Ioc4Sep_t, MPI_POINTER pIoc4Sep_t;
>   
> -/*
> - * Host code (drivers, BIOS, utilities, etc.) should leave this define set to
> - * one and check Header.PageLength at runtime.
> - */
> -#ifndef MPI_IOC_PAGE_4_SEP_MAX
> -#define MPI_IOC_PAGE_4_SEP_MAX              (1)
> -#endif
> -
>   typedef struct _CONFIG_PAGE_IOC_4
>   {
>       CONFIG_PAGE_HEADER          Header;                         /* 00h */
>       U8                          ActiveSEP;                      /* 04h */
>       U8                          MaxSEP;                         /* 05h */
>       U16                         Reserved1;                      /* 06h */
> -    IOC_4_SEP                   SEP[MPI_IOC_PAGE_4_SEP_MAX];    /* 08h */
> +    IOC_4_SEP                   SEP[] __counted_by(ActiveSEP);  /* 08h */
>   } CONFIG_PAGE_IOC_4, MPI_POINTER PTR_CONFIG_PAGE_IOC_4,
>     IOCPage4_t, MPI_POINTER pIOCPage4_t;
>   

