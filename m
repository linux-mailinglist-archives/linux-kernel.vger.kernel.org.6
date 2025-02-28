Return-Path: <linux-kernel+bounces-539553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF502A4A5CC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEA81172850
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FC01DE4F8;
	Fri, 28 Feb 2025 22:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCWAvzRT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDCD1C54AF;
	Fri, 28 Feb 2025 22:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740781431; cv=none; b=ou0OfbWQLLddC1J5JHLrELMAicsWJE/SB8/S27QNXSU8CC7un18boZYB3rv5JxoDHEM1wSwC2GaCUg36zcDMnrV5df2NaPpkpNbOI1nFHfsXnm/WYtv86KCLS8CWQSDN0GceDyqAyYEzuhTb8OBv1VSEnxmF9I3SXsc0Nh122/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740781431; c=relaxed/simple;
	bh=nqMKrBalPdNqM1OuUbRe/HDaHwAsfDjsT4mPBPreChU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=slWXOBxM+CP5jK+5LIq8z7JHr4ORlpUXCHnR2KF/oPT2yAkMvBxsyw2oND28WNC8YBX4Nk7GrsJfNvkUVUR5okIcGZp9+HFGmwIwDo529DfB9rUHiCW3BaFcwK0RC7rZjBTupnCDtbP+HVPv8qiCsJD5VuC6n6ZqQwzWQlWjM1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCWAvzRT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB482C4CED6;
	Fri, 28 Feb 2025 22:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740781431;
	bh=nqMKrBalPdNqM1OuUbRe/HDaHwAsfDjsT4mPBPreChU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KCWAvzRToKfvH/cM8ERsZPK9fqVjB6yF3k9HKNoU6xShSoPtwJJMxZz669FKPj0IK
	 hUdUkY4XpuRUJM8nbBA1asogIpSkdt06NcrWbCfkfBX4Hv2FmZ+7cHDzKa5+Fl9Ic4
	 UHyOwKcNQAsobsqpr1gSycgP8od/PxYk282WCfw+HbgaIiIxYm20x0Y6KavFh3Kz/6
	 E9Sj1WwEXU4gQDqL/IfQUADLMbOs2ZQr4I24k4H2CuJsG754TI0NQJDTpK+zzacCZB
	 0Whe6GqV4pvRLBs5Vw9PLUKFAF1t0sLXfMCCLQ55rd1XGvBsMnvY6/5BoYIhGgMpsu
	 y76DXpwculfjg==
Date: Fri, 28 Feb 2025 16:23:48 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Leonardo Felipe Takao Hirata <leo.fthirata@gmail.com>
Cc: vz@mleia.com, skhan@linuxfoundation.org, tglx@linutronix.de,
	conor+dt@kernel.org, krzk+dt@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: interrupt-controller: Convert
 nxp,lpc3220-mic.txt to yaml format
Message-ID: <174078141457.3783766.17433584674723106714.robh@kernel.org>
References: <20250228034021.607135-1-leo.fthirata@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228034021.607135-1-leo.fthirata@gmail.com>


On Fri, 28 Feb 2025 00:39:15 -0300, Leonardo Felipe Takao Hirata wrote:
> Convert NXP LPC3220-MIC to DT schema.
> 
> Signed-off-by: Leonardo Felipe Takao Hirata <leo.fthirata@gmail.com>
> ---
> Changes in v3:
>  - Add interrupts property description
>  - Fix interrupts items descriptions
>  - Remove else condition
> ---
>  .../interrupt-controller/nxp,lpc3220-mic.txt  | 58 ----------------
>  .../interrupt-controller/nxp,lpc3220-mic.yaml | 69 +++++++++++++++++++
>  2 files changed, 69 insertions(+), 58 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/nxp,lpc3220-mic.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/nxp,lpc3220-mic.yaml
> 

Applied, thanks!


