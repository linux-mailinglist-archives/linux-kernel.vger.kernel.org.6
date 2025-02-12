Return-Path: <linux-kernel+bounces-511885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80961A33105
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 21:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8B973AA646
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C2A1EEA4A;
	Wed, 12 Feb 2025 20:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YYRYO1Oj"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C5327183B;
	Wed, 12 Feb 2025 20:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739393312; cv=none; b=KmRxSkJ8La2JV3Ra7y0OaxP2qWlQJopJD4b2BwiLVRc5XSKD23duPU7LNVtYKXKsHxDDCgDt1Csu7wp8Hh0vOPD3v0KZF3g7igVH3lIPwqT+yueCwCJjLsk0WvwgYVkP6CQQ9oXD9zOP1iIci9Myba+9QVJrMICfZYJx8RA2AOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739393312; c=relaxed/simple;
	bh=Ynjcg/wBAh7toCB0/mDBaDazWwr2eUsLbQ9/GS1Hxn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zjqp72wYGu1XM7WWp+fjK0cVvSbwGeG7nqjArwzZwToZGuLxgtOKgwAJH6WX/a/ZOM9unIZi2c4+XfKGfsJyCDMDUiEjxF8b9b9ZVYw0duSCpaLwlrzFQFh/YmAIfETAdtWk1VLKpHp29AAiPEscKQhSltFPlwTJBolaGKruJw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YYRYO1Oj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EwJX+/PWZhhxXieABK1r+Cs6kda0dREWNvtRzcjq2PA=; b=YYRYO1OjbfN1ipIniBiMRwfD+Z
	HzCz8ntig54vjPXSymcaB7nyxWrvp1OGaJSBBNnOF4WYL+vqjSVcskfzlDaeDAEJPlgdVbrOVeRJR
	4WKmKc9PotsJ+bZay6XeLy0DXGIbOgp1LxyloLASbWP1uVfw+GrTthSwq+QfRUBnXGuo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tiJeh-00DVhn-4v; Wed, 12 Feb 2025 21:48:23 +0100
Date: Wed, 12 Feb 2025 21:48:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] ARM: dts: marvell: armada: Align GPIO hog name
 with bindings
Message-ID: <b4b4c809-6f25-43a7-92d1-e9d16a09249b@lunn.ch>
References: <20250212204156.57261-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212204156.57261-1-krzysztof.kozlowski@linaro.org>

On Wed, Feb 12, 2025 at 09:41:56PM +0100, Krzysztof Kozlowski wrote:
> Bindings expect GPIO hog names to end with 'hog' suffix, so correct it
> to fix dtbs_check warnings like:
> 
>   armada-385-clearfog-gtr-s4.dtb: wifi-disable: $nodename:0: 'wifi-disable' does not match '^.+-hog(-[0-9]+)?$'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

