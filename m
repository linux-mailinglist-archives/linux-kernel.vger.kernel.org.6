Return-Path: <linux-kernel+bounces-269904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A6894384F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 23:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2E5E1F22700
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 21:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070F316CD1E;
	Wed, 31 Jul 2024 21:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGgBOK7g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411D814B097;
	Wed, 31 Jul 2024 21:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722462931; cv=none; b=SD92M/N83miE+AV2Qq9lg2QzwpWXobEx2PU+Jsoze+jaEWUZWgPV2yYs4b4Ax9HVBFoCrr2/StE/A61gI60XZuv4Qxe2fXj4GQbz0EwqeQW4Xk/IGhUFlkOJn82qZzh5UOmwHZ72WpsiSeEOzF7MXNVyWrNLzNxcCinmXnyuxdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722462931; c=relaxed/simple;
	bh=UfRDdoZZSuPE3GN1zngoBkyWIbZUKNulriNHcPlR22I=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=sGkSRnSiv0d/Lwxhartpm096QTUdiH+rWhZ5ixIwDmoQzY55JJ3Ne4nSQ0JD3JyATKTPgbFZNirunmQID3UC15K2YliZpPYAJj9i59qv1tP3JqixcCxZ7likvrjUbV3kveNjPFrA4g6Q1GRRS6SBa6BEoVYkkAOqgSXLbhVJ7hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGgBOK7g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACBD0C116B1;
	Wed, 31 Jul 2024 21:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722462930;
	bh=UfRDdoZZSuPE3GN1zngoBkyWIbZUKNulriNHcPlR22I=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=aGgBOK7glM+7nPbm3+VBDtDQW1k5DcJoeLpK84FFon0DhNT4ZpGdzL+zGhvD2XXKX
	 ePyloO6tth5a4vnb2AEMzf56VkO8k9urDhnh7XtfGs4AnFFzPqplCnW6p9+fR9vzn4
	 xZc6R1IPB00qG9z8QgjQw9c3HUqZRpGdYLW8AlFZ4B1WuNwZEPo6f2PlHsMguTBKvc
	 pmFrQMvvQrn1RXy96sDiVQkBz4x39MOEAX5rgVR8VmcvxfdQj7mKUn07gsMBClZQ3/
	 vyZkp8/iH9i2/ANZZ6wOXggjUitkgy0vW0Ux+NS6IMKVccLmbIzlvl/potqDwlH7qF
	 Z5R2ZW803QaTQ==
Message-ID: <622931aa4c0efea7838d2b2015d3fb1d.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240731065137.156935-1-animeshagarwal28@gmail.com>
References: <20240731065137.156935-1-animeshagarwal28@gmail.com>
Subject: Re: [PATCH v2] dt-bindings: clock: nxp,lpc3220-clk: Convert bindings to DT schema
From: Stephen Boyd <sboyd@kernel.org>
Cc: Animesh Agarwal <animeshagarwal28@gmail.com>, Daniel Baluta <daniel.baluta@nxp.com>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Date: Wed, 31 Jul 2024 14:55:28 -0700
User-Agent: alot/0.10

Quoting Animesh Agarwal (2024-07-30 23:51:33)
> Convert the NXP LPC32xx Clock Controller bindings to yaml format.
>=20
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
> ---

I'm not sure if I'm supposed to pick this up directly or if some NXP
maintainer is going to do it. There wasn't anyone on the "To:" line, so
I guess I'll pick it up directly.

Applied to clk-next

