Return-Path: <linux-kernel+bounces-375739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD2C9A9A36
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 08:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C6651F2321D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 06:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0989EC8FE;
	Tue, 22 Oct 2024 06:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="cF5FV/w1"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51811465BB;
	Tue, 22 Oct 2024 06:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729579590; cv=none; b=pP490zw/cFy2RlC3dIvVJj4QOEmBkWSKSJYgqY81/b/eUDYXBGAFO/j9fCizYZbthnpC4ITbT28NpIVDep9LGpmiCheTNWocZIYaH3BJ4kKYuV0fkKLZUBFBeLUEOKHF72JjojC+pQTwEXwHu+0pRc/hSYUle0l5+kenZI/fG0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729579590; c=relaxed/simple;
	bh=Khj87fNVKU3GsuLBvh0Aq9O2v3YB1Pzl/kVwuafwiSI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oXRaWcbv8ZeOxC8ST5F4BoiPMeJyDWzj4ASpmpUDZ0N+KtUlxMRn//X+/Dsex3w1ePyA85E9JrwFTtNu1lP4ovf8meM7vktuQSAHn/b08hNDbUqHlhQKSAb5RetP8itWrKBnrQo42Abu8cJw8VvdDePgO+/TAYVHrr0onkEXJsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=cF5FV/w1; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=OFvkNSOe6E5Pxsw9UfnAUjaYsSKQZWEKW1KouM5WGco=; b=cF5FV/w1+qVf44qS7mDbBCLr5G
	hV0kVprJAGZbEd3gHMZk2itdTKV6fY4sVjnRRG+ctuvnFk5QBOcJYMJnZrT6LnWK3+/Uep9INQwy5
	VU/c6OKbBof0Z/PFOGj5MLPqJJkW8MNr9BRL8//UlyvU4Gx6uBsga7R77/7xTE4MiZJCFrMIw9TeQ
	2ZL3dZYIxHBvKc1aDsGCe0/BRz4YwVE/vtzwNJ6D+TTzqmRjCT6cZOqIJ0Kc2PZ1fFmEKuZYwr2Ho
	44ZIGNG4kpSQy6eow+Mxdqk7Lt5GLiXpl4XGJ+DluMyiKzlHJMDEMPjdVMS8wv7LxSQDZmqqMCQPw
	jD2+U9kw==;
Date: Tue, 22 Oct 2024 08:46:13 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Shawn Guo <shawnguo2@yeah.net>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6sll: fix anatop thermal dtbs_check
 warnings
Message-ID: <20241022084613.5d126c01@akair>
In-Reply-To: <ZxcdYudAHVSykFoW@dragon>
References: <20241021183244.303329-1-andreas@kemnade.info>
	<ZxcdYudAHVSykFoW@dragon>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Am Tue, 22 Oct 2024 11:34:58 +0800
schrieb Shawn Guo <shawnguo2@yeah.net>:

> On Mon, Oct 21, 2024 at 08:32:44PM +0200, Andreas Kemnade wrote:
> > Fix anatop thermal related dtbs_check warnings about node name  
> 
> Can we be clear what the warning about the node name is, too long?
> 
soc/imx/fsl,imx-anatop.yaml explicitely specifies the names of
allowed subnodes and mandates the name tempmon.

Regards,
Andreas

