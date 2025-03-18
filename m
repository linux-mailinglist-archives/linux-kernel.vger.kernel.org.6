Return-Path: <linux-kernel+bounces-566291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D2CA675F3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37E8417A754
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD1420DD71;
	Tue, 18 Mar 2025 14:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="f3xxU78P"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6A914A8B;
	Tue, 18 Mar 2025 14:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742306918; cv=none; b=jyQDJn0e7f5Z+Rvh7CnwxGxflYmGu2RepROKxHcv2s0BeVDz+TphB7C2PYoixM4ExHVo+pzPYLiwHkv686L1nq5dDZhvLY+Hs15e1++LgTo6LRMJmER+Q39uW0JBapEu35uWf306UwRLauf4hy9uGq3zInjCUAtPmkUMHrHHS90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742306918; c=relaxed/simple;
	bh=b3BwaNDcKCUP/7KouSzxpXIt9WfVHezzFGaH/a198q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nT5kxxrmB1ylUjBcr0WyBx41qAt2ojnxFmpSZeKFLXm2XOp2H1EtCfFjPWGN60HN9ox4i9A/NGXNmBqnSQopbXqyWlaMM8+JH6/Jfhter9AI8kj3KJXYgDCdSextqurL6eEDMAXLBl2B+8b8RfKr4hcvTEbC0BsF05jRG+eYNkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=f3xxU78P; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6WvnC7tPRCiTGfBn03Ur3Jt4abVexUVYYSSyZJJAuRc=; b=f3xxU78PYsEzV8e2vE0hjY8cZv
	QKGKQ4yxcn4g3xNicVzFoSWgnFFV1ZoBWr+f9vM5TNqt4pQD2Po6rMn/LPNl7SVnV2FE2uuvFlOpN
	cyDov92u2+PhX35F580TxmzowUuc1mQq4S10h/4A14p6+6NOKebs6wvL+/R0eW9a6K+I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tuXcG-006GhC-8b; Tue, 18 Mar 2025 15:08:24 +0100
Date: Tue, 18 Mar 2025 15:08:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Rajaganesh Rathinasabapathi <Rajaganesh.Rathinasabapathi@amd.com>
Cc: devicetree@vger.kernel.org, openbmc@lists.ozlabs.org, joel@jms.id.au,
	andrew@codeconstruct.com.au, robh+dt@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Supreeth Venkatesh <supreeth.venkatesh@amd.com>
Subject: Re: [PATCH v3 2/2] ARM:dts:aspeed: Initial device tree for AMD Onyx
 Platform
Message-ID: <fdd969cb-aa2d-4d55-949e-e2631757221e@lunn.ch>
References: <20250318041224.1693323-1-Rajaganesh.Rathinasabapathi@amd.com>
 <20250318041224.1693323-2-Rajaganesh.Rathinasabapathi@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318041224.1693323-2-Rajaganesh.Rathinasabapathi@amd.com>

> +&mac3 {
> +	status = "okay";
> +	phy-mode = "rgmii";

Does the PCB have extra long clock lines to insert the 2ns RGMII
delay? Or are you another victim of aspeeds broken MAC/SCU driver?

       Andrew

