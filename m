Return-Path: <linux-kernel+bounces-399058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5709BFA4F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 00:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2152D1C21F47
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 23:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73619201029;
	Wed,  6 Nov 2024 23:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="KS40TnrW"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43830383;
	Wed,  6 Nov 2024 23:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730936569; cv=none; b=igVG1e8DjuH4paD31D/UJVwPLnXXnW8ebfBwYFihtD8fgOwMcoBCKUYOhrJWbhAXmv6oW+PhD7wWtAX2EdJf1d6WVXnpi+jvsNc3ORroGQOHGV4vgmoUQZ1P0GaB6msTxCRSDu1qCTyVFIzO3iI1t4/KM6ckwAjNJnDv4P+MbSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730936569; c=relaxed/simple;
	bh=RbaXcDiI9VKQ24EWX+KiopF96b7wPeWxBZ4dioG1uoM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ar5GBmSfk9Bst24oRzGq5q4sZUMADFs6mks71pXdFt7PyvucaBwg49bfCDyQzoy+SWBnmMWuqOX8PnZx1cYwnhDi4ECuHGSNccPNJvE8Q/JJfpt8OgxbkH7BE3X1XeDtLJGvQ1aPAvHTtCNQIQ/51Y9+fa8VoYX/UhOboduh4kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=KS40TnrW; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1730936566;
	bh=RbaXcDiI9VKQ24EWX+KiopF96b7wPeWxBZ4dioG1uoM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KS40TnrW8Q4bk1DyTkKfLOstKJyzBhfs5ZulLiWbEpfar7mxzWJ3GXGlcfD+5+93l
	 zr3C+mL+qwB39ZIWNMJEvyFAl6UzFgJ86J39fiM/68WrJQSfXlimFGquBaG+eQKmqS
	 xSYc7YkYYDT2dTzqPpFdCqU1Yb0fbIq2jI7oa5+wsm8V3onLLAtbXQkzTUjLR0D685
	 hwLFYEplpiSWky/Jqv6+gFhqGqxQVDZCiY5hOSO991mliNUYT5BXyu8dev0r3iSLpT
	 LtzmQPPbhvZzhUKiwxWEQLla6BjzFYVPjXdcgSF97fD75+Gq8l3qS6WPrIli+iRsHS
	 WzAC2aVletFAw==
Received: from [192.168.68.112] (203-173-7-89.dyn.iinet.net.au [203.173.7.89])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 780016B4F1;
	Thu,  7 Nov 2024 07:42:45 +0800 (AWST)
Message-ID: <361ed68842698f0f07f01bbd474367908b699bbf.camel@codeconstruct.com.au>
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: catalina: add hdd board cpld ioexp
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Potin Lai <potin.lai.pt@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>, Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Potin Lai
	 <potin.lai@quantatw.com>, Cosmo Chou <cosmo.chou@quantatw.com>
Date: Thu, 07 Nov 2024 10:12:45 +1030
In-Reply-To: <20241106-catalina-cpld-ioexp-update-v1-2-3437bcfcb608@gmail.com>
References: 
	<20241106-catalina-cpld-ioexp-update-v1-0-3437bcfcb608@gmail.com>
	 <20241106-catalina-cpld-ioexp-update-v1-2-3437bcfcb608@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-11-06 at 16:58 +0800, Potin Lai wrote:
> Add HDD board CPLD IO expender based on latest CPLD firmware support.

Can you please be more specific regarding CPLD firmware versions?

Andrew

