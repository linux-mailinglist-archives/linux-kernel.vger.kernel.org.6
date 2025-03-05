Return-Path: <linux-kernel+bounces-546230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C39C5A4F81C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38BF0188A7CD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 07:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B061F4720;
	Wed,  5 Mar 2025 07:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PeInuU8E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C351EEA33;
	Wed,  5 Mar 2025 07:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741160489; cv=none; b=lWwPmUMa2/Ea5oUrhAI98vYrBvhOC/ngK/jJoSO3TVykXX1brNLYAzpi46XoBLY8Qs28NtaKljn14M0Yr3qJsc02KtbZBXYcgNJSOUZCjycbUHyKh63v/ly/cecpr1HolAVhZruKJ64q10JTpLWFypiLNWGZ4diKyEhBBoh/YeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741160489; c=relaxed/simple;
	bh=UuyCdAeL82f1TOp2yggcFOeln/rSj3JTG5r77qmxK/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjF6Cc2kqP5C0AlSAJtGC6sLPwzQEBnG5sV2mqtlFv6z4F7XCQh7DIFC5JPduHzrj5+Km6PAKaklecpFYqA7UKDdwV/toNTXHoQECiXlcGX3JwMjfWtZE7j5jHE9HDh9dMok/wFX7GBArW/GcYjDqyjO6WWN7EKYbmUADGpIPQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PeInuU8E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996FFC4CEE2;
	Wed,  5 Mar 2025 07:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741160488;
	bh=UuyCdAeL82f1TOp2yggcFOeln/rSj3JTG5r77qmxK/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PeInuU8ERkePr17howrYPFxignmA/MsTwZ4u8d9jO1tVpwezDDFSoQZpIOA/TgDgk
	 P+9yMOtNFsBwaqdPYdHA40mfnQnjnKTyeWyIS9bj+prPV2FNUkzV+3mT0bVEk64rHK
	 uaRo8YUBglpG2OgVqzUvRI4Hvto8dpVi9qZMs643jj2Nea56dwhBh+F4kq+fo4u/k1
	 ZAiyYYuwHNk2nw5hZUxIFDWNSP2HrjIfLGzmqt5o/mNBJF8U/QGTbO40M8/MiBVcJU
	 +beHC6obrfIQlYHfbIM+dKzKR0SMiyXWM9kD6o+V9muHhkLOHPjZlYMbXABIi2aHcJ
	 1nwB7/ID7D3LQ==
Date: Wed, 5 Mar 2025 08:41:24 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/15] dt-bindings: arm: sunxi: Add new board names
 for A523 generation
Message-ID: <20250305-gigantic-dinosaur-of-perspective-c3acad@krzk-bin>
References: <20250304222309.29385-1-andre.przywara@arm.com>
 <20250304222309.29385-11-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250304222309.29385-11-andre.przywara@arm.com>

On Tue, Mar 04, 2025 at 10:23:04PM +0000, Andre Przywara wrote:
> The new Allwinner A523 SoC family comes in different packages, though
> they all share the same die, and so the devicetree bindings.
> 
> Add three board names that use a version from this SoC family:
> - The Avaota A1: an Open Source hardware router board.
> - The Radxa Cubie A5E: a typical development board
> - The X96QPro+: a TV box
> 
> Add their compatible name to the list.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


