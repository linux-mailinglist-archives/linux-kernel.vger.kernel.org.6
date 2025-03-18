Return-Path: <linux-kernel+bounces-566743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D32A67BF7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 19:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D58443BE34C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52FC1DD88F;
	Tue, 18 Mar 2025 18:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RMxWdN2A"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD61151990;
	Tue, 18 Mar 2025 18:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742322809; cv=none; b=EHuy/WP9RreEF1/EgXboopprFTVxIhYwtydtctRFjG6nv4SbvUTI6c/17DneKDd3GyQcdwvNIKqUlqWiMd9myXOXAgwhusgoj2wQ+xoOu5e61lZoeMQz3H/yB97e+eLHYWZdHl7/X6VPafkzrLXkh3FrLE3uDpaclZXAKssOaLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742322809; c=relaxed/simple;
	bh=e3q2XYjoCADYcJeRJzXc1Ma0b9G6EXb15Q3XUeNMPiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kcN5JHWXZd0LcJSTiAUU7UU6+ZduTLL1Kd+qiX6eDziEHUlxnRkxdoL/LSK5BPcW56CsCt+sg8bxP1xLsOJa4Ia3gXkWWIcTt0LsR5xoSghKPIx2/6c+HWvX2l+4p3qvnP01zmiQoYBlxtojbsiolLaWeDLdXlN8LfiK+NelRt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RMxWdN2A; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iguVmCV3+e0iktCJiQX2Pt4HvULaD7BI01tc98Ba7EQ=; b=RMxWdN2A+yps4F+Jz/2Bu2jjSe
	RnJciZfoyRh9njrYyXR+wAngSHAUdkwjGUYjMb8VDdkOK1sTv1ICcsje0dJ4iLwyUuSsARc7HdRZz
	vLDyrvv6iYeLoo+VI1G/ZCA8OinwMWRoLt3Db7UhfZtUmmPco8jDdOjHYvOXB5oTT7PQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tubkT-006IOL-Rn; Tue, 18 Mar 2025 19:33:09 +0100
Date: Tue, 18 Mar 2025 19:33:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Rajaganesh Rathinasabapathi <Rajaganesh.Rathinasabapathi@amd.com>
Cc: devicetree@vger.kernel.org, openbmc@lists.ozlabs.org, joel@jms.id.au,
	andrew@codeconstruct.com.au, robh+dt@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	jothayot@amd.com, Supreeth Venkatesh <supreeth.venkatesh@amd.com>
Subject: Re: [PATCH v4 2/2] ARM: dts: aspeed: Add Initial device tree for AMD
 Onyx Platform
Message-ID: <472a4f78-24f4-4bfd-bf99-8b1194bfe8f0@lunn.ch>
References: <20250318174730.1921983-1-Rajaganesh.Rathinasabapathi@amd.com>
 <20250318174730.1921983-2-Rajaganesh.Rathinasabapathi@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318174730.1921983-2-Rajaganesh.Rathinasabapathi@amd.com>

> +&mac3 {
> +	status = "okay";
> +	phy-mode = "rgmii";

Still broken. And it appears you are just ignoring my comments.

Sorry, but:

NACK

There is a discussion here:

https://lore.kernel.org/lkml/20250317025922.1526937-1-jacky_chou@aspeedtech.com/

There is also IBM in a similar situation to you:

https://lore.kernel.org/linux-arm-kernel/20250108163640.1374680-6-ninad@linux.ibm.com/

and NVIDIA

https://lore.kernel.org/lkml/20250312045802.4115029-1-wthai@nvidia.com/

Could i suggest you, IBM and NVIDIA work together to get Aspeed to fix
this.

	Andrew

