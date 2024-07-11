Return-Path: <linux-kernel+bounces-249694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E6B92EEA9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 20:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE0F287F50
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D176C16DC36;
	Thu, 11 Jul 2024 18:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="P/4wmUY/"
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF0586AFA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 18:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720721845; cv=none; b=F3dLj2bN2tREU4gF8U8GOvNA4Zqja4cDNilWMAheRCOJnqJckstHcML5twsVyMEDu9MZMdPOyInsUQoZOKBypWXPQtofL4iLOZEPtHXJlRvwn1h2eDbpE0CxNNJS0STG1gN6T4J0z8dD7hu2M4HGTKoM3fNkKFlp+5rhx7TdziQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720721845; c=relaxed/simple;
	bh=m9ci2yNa+HxZGAZvkfWqviCIyVM2pW4WE+34Zzg+gqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bQ6S7TwfGLB70eLUa6e12TsuP1jUuOTq3TjaeVSHuRt4ydmWSN25WN1PZ6fwFbv4aAajxfbLbHWur9V0tE2RmoP3pRwDZW/HQ8euhCnFT/QKRK81s82CzBeAttxfMqxzjhV96a9/fNpklX2fLEUmxKDEKVSoXjflhMJOJ3ENpFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=P/4wmUY/; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
	by cmsmtp with ESMTPS
	id RszWslZRmjnP5RyM6sYOso; Thu, 11 Jul 2024 18:17:22 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id RyM5siGWYuKXMRyM5sm0ho; Thu, 11 Jul 2024 18:17:21 +0000
X-Authority-Analysis: v=2.4 cv=ANnGoFku c=1 sm=1 tr=0 ts=669021b1
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=Q-fNiiVtAAAA:8 a=3O__t03nxoAqBYxMqfAA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=Fp8MccfUoT0GBdDC_Lng:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cTwOtyCJTb+GvXLybnV8tGTSn4CH7/gLVA4lCx4WiTk=; b=P/4wmUY/P4LpzNzOsc1r+nvWpl
	3RH8EJ6Rkhd/+TcqiYRE0Xk9aHodGsKBYK2GUIpIg7OQZgjTseVzFyKlfPWLm+280WHVw2pNQTmfX
	TpzCBQ3SUIh/+kL30JWnlsfJ3+sQ2lcChEM7JVA5fOMitHmRgppCYt8I4A+bs/lfOeh+p5RWc3pRf
	XmBGn7hlomOtTVYmQDNFA9o8qylOe/u7i5d/NK8KeS45lHonKDo5xifw+9Qu0OVMIT2jmrCVDfGbI
	YVJGWEyx89RgQA4djr5zcZIwtvhdwfg/Zlvy22Sp4xcQ2jSXzbD3m9v2wEKUA9yw7pGxCqXWN5F2X
	A5SxdVDQ==;
Received: from [201.172.173.139] (port=34668 helo=[192.168.15.4])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sRyM4-002KJg-1p;
	Thu, 11 Jul 2024 13:17:20 -0500
Message-ID: <359fbd37-67a6-4a1b-81b9-f551c5205a54@embeddedor.com>
Date: Thu, 11 Jul 2024 12:17:19 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] scsi: message: fusion: struct _CONFIG_PAGE_IOC_2:
 Replace 1-element array with flexible array
To: Kees Cook <kees@kernel.org>, Sathya Prakash <sathya.prakash@broadcom.com>
Cc: Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
 Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240711172432.work.523-kees@kernel.org>
 <20240711172821.123936-4-kees@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240711172821.123936-4-kees@kernel.org>
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
X-Exim-ID: 1sRyM4-002KJg-1p
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.4]) [201.172.173.139]:34668
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 43
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfI9SfOptxWDbxkbopECgZ3pu6uJ77cIIKIQbC0sglsRPasYAJB5rxWbhuc8ENPWpVCWEfuwOcLRC+54Ea+GEiLFy/tS1GU8TleM4KiTBncPNZImPube3
 Op7T6Va9wKei6vWZKClXdBF71+W+Br/Gc7q6SJj0zdAhz/tqfiBRllBUBTkww66a2bj9yIMregidYqmttMSgw7eQskTB5yKJi42z+IRFs80/6nySF5gd7Wpg



On 11/07/24 11:28, Kees Cook wrote:
> Replace the deprecated[1] use of a 1-element array in
> struct _CONFIG_PAGE_IOC_2 with a modern flexible array.
> 
> Additionally add __counted_by annotation since RaidVolume is only ever
> accessed from loops controlled by NumActiveVolumes:
> 
> lsi/mpi_cnfg.h:    CONFIG_PAGE_IOC_2_RAID_VOL  RaidVolume[] __counted_by(NumActiveVolumes); /* 0Ch */
> mptbase.c:      for (i = 0; i < pIoc2->NumActiveVolumes ; i++)
> mptbase.c:                  pIoc2->RaidVolume[i].VolumeBus,
> mptbase.c:                  pIoc2->RaidVolume[i].VolumeID);
> mptsas.c:               for (i = 0; i < ioc->raid_data.pIocPg2->NumActiveVolumes; i++) {
> mptsas.c:                                       RaidVolume[i].VolumeID) {
> mptsas.c:                                       RaidVolume[i].VolumeBus;
> mptsas.c:       for (i = 0; i < ioc->raid_data.pIocPg2->NumActiveVolumes; i++) {
> mptsas.c:                   ioc->raid_data.pIocPg2->RaidVolume[i].VolumeID, 0);
> mptsas.c:                   ioc->raid_data.pIocPg2->RaidVolume[i].VolumeID);
> mptsas.c:                   ioc->raid_data.pIocPg2->RaidVolume[i].VolumeID, 0);
> mptsas.c:               for (i = 0; i < ioc->raid_data.pIocPg2->NumActiveVolumes; i++) {
> mptsas.c:                       if (ioc->raid_data.pIocPg2->RaidVolume[i].VolumeID ==
> mptsas.c:       for (i = 0; i < ioc->raid_data.pIocPg2->NumActiveVolumes; i++)
> mptsas.c:               if (ioc->raid_data.pIocPg2->RaidVolume[i].VolumeID == id)
> mptspi.c:       for (i=0; i < ioc->raid_data.pIocPg2->NumActiveVolumes; i++) {
> mptspi.c:               if (ioc->raid_data.pIocPg2->RaidVolume[i].VolumeID == id) {
> 
> No binary differences are present after this conversion.
> 
> Link: https://github.com/KSPP/linux/issues/79 [1]
> Signed-off-by: Kees Cook <kees@kernel.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
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
> index e30132b57ae7..7713c74e515b 100644
> --- a/drivers/message/fusion/lsi/mpi_cnfg.h
> +++ b/drivers/message/fusion/lsi/mpi_cnfg.h
> @@ -1018,14 +1018,6 @@ typedef struct _CONFIG_PAGE_IOC_2_RAID_VOL
>   
>   #define MPI_IOCPAGE2_FLAG_VOLUME_INACTIVE           (0x08)
>   
> -/*
> - * Host code (drivers, BIOS, utilities, etc.) should leave this define set to
> - * one and check Header.PageLength at runtime.
> - */
> -#ifndef MPI_IOC_PAGE_2_RAID_VOLUME_MAX
> -#define MPI_IOC_PAGE_2_RAID_VOLUME_MAX      (1)
> -#endif
> -
>   typedef struct _CONFIG_PAGE_IOC_2
>   {
>       CONFIG_PAGE_HEADER          Header;                              /* 00h */
> @@ -1034,7 +1026,7 @@ typedef struct _CONFIG_PAGE_IOC_2
>       U8                          MaxVolumes;                          /* 09h */
>       U8                          NumActivePhysDisks;                  /* 0Ah */
>       U8                          MaxPhysDisks;                        /* 0Bh */
> -    CONFIG_PAGE_IOC_2_RAID_VOL  RaidVolume[MPI_IOC_PAGE_2_RAID_VOLUME_MAX];/* 0Ch */
> +    CONFIG_PAGE_IOC_2_RAID_VOL  RaidVolume[] __counted_by(NumActiveVolumes); /* 0Ch */
>   } CONFIG_PAGE_IOC_2, MPI_POINTER PTR_CONFIG_PAGE_IOC_2,
>     IOCPage2_t, MPI_POINTER pIOCPage2_t;
>   

