Return-Path: <linux-kernel+bounces-268688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA429427DE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FB941F21E06
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD0B1A7200;
	Wed, 31 Jul 2024 07:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gFC4+cJv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AD71A6183
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 07:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722410860; cv=none; b=dDfm1XNUFduY2q2sPJzka+eaWEYkco6s7Po5j927iiJRhQhQUwoBaGbLRTcnrSFdvBycKqCEFElwgd0GawPrHFeIcoGxcB3Gk6QZki3IFAYnC8TXeg4LWZJiSibK8oujeiCaNa2s3t3A1YqeZfPkSbI+zU/vWRGCGZ32KkqXkRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722410860; c=relaxed/simple;
	bh=vMSVrm2H7IIgj2CCjrTZdR6I6T23lvRa9R7hrIMkNMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hW+gvlq8vfulvdTrzGusnIk0qdHvP1UoUtQ4b3aDxTtevMyVGFPviFeZNEQobFdwmcyh3iNyqe9YJ0t09ocnddocYVtRnkf9z6RuveGxztdxvs4ggscsPsyg359bEXhI1g4XLr6/ViXf3752W+5ffYIE1Wp6/lcgQSRmeKTuP1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gFC4+cJv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC19C4AF0B;
	Wed, 31 Jul 2024 07:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722410859;
	bh=vMSVrm2H7IIgj2CCjrTZdR6I6T23lvRa9R7hrIMkNMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gFC4+cJvdRRETguTEhsxoHbEZqd6oRfVA3eEDBv17J20sJfUJ5tbWPBKLsmLKsDB8
	 NWvNJ3yA3ccGCsFcR6o95Eg1igZirje8SSgfQumKJ2B8c6O5qY0twTqbsxWaBYMbwU
	 q05WA0W9HN9hamCuWMGlmhtmGnMWBQJJCGjDB+0U=
Date: Wed, 31 Jul 2024 09:27:36 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"opensource.kernel" <opensource.kernel@vivo.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIHVzYjog?=
 =?utf-8?Q?gadget=3A_uvc=3A_Fixed_th?= =?utf-8?Q?e?= abnormal enumeration
 problem of  mobile phone as UVC camera.
Message-ID: <2024073115-level-tiring-903d@gregkh>
References: <TYUPR06MB6217E6066E3A74EDE86FED1FD2B12@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <TYUPR06MB6217B2E6F3DEBE87541336A5D2B12@TYUPR06MB6217.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYUPR06MB6217B2E6F3DEBE87541336A5D2B12@TYUPR06MB6217.apcprd06.prod.outlook.com>

On Wed, Jul 31, 2024 at 07:03:41AM +0000, 胡连勤 wrote:
> Hello linux community expert:

<snip>

Please fix your email client to not send html email, as the mailing
lists reject this.

greg k-h

