Return-Path: <linux-kernel+bounces-358067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 589809979DE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 02:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19EB0285341
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 00:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC6D2BAE3;
	Thu, 10 Oct 2024 00:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNfmedkq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D90FC08;
	Thu, 10 Oct 2024 00:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728521510; cv=none; b=VGbiC6WGFGqhNt9QtSuXm3Koc0vUhAxVUjiOf0nD1/WiDKm6RySl3a2b65xcWzFyjo/r1oJGRVUoagLwRymimGRJtujZJEjQaRJxpDQh1vjt/zXIc8g8I9CR5JkxJekNeLmvesQZZeqQxysIXlCZiYKqzGqwwIcUU9M+KqWWLK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728521510; c=relaxed/simple;
	bh=HtoERcNIgQ8FgjF2tEAibYPvrOsWy7edv1YdtfQPfWU=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=P5ngtQSsYsO3savF46bXdJeeT6d3bLngRQlVlxnd3/g34kvC9zdAdpvbUDsz1BlVcSad2YTfUvPFS1XznMkZIXl6uySFis+73iF7kTDGMwwuSmgHRdb9kARfFGgCZFva4LZb6HYWqR+nIs74Q1gvFR/ujFL1XK5sKGc+xW72TAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNfmedkq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2D8C4CEC3;
	Thu, 10 Oct 2024 00:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728521510;
	bh=HtoERcNIgQ8FgjF2tEAibYPvrOsWy7edv1YdtfQPfWU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=hNfmedkqKMyoFOJA3gYeza52+HpxWQqYyWIiCfbKepDwZUaM4mUKWymiKG2HcSc+L
	 rr65FFDaPLXI5Rnts6CWKBpAmRdBFEh6jnRBuSlHxX18A9lyce0+bn50zUsU58O5Tc
	 AjW68Cw701cZ5PUXVXOqJUABTtJacOzru7dYXO7TASMlt1L9x+yaXHa/VpkjVPKN1V
	 3AaaiyNTI9ZzhIJa5kpgtWF7erWfFGjupkC71G3+lv/pMbe71Ktn1OkRdo1NFHE1iD
	 J8e66mouGMNOOzOdoyFtD0v1V3FZWBwkxat93qEUjj5CbyiwB3TRnuKVubBvFSr+pV
	 3V12D3YTLnP4Q==
Message-ID: <4606daeedc8a267e30cf572cd221847f.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240913191037.2690-6-hpausten@protonmail.com>
References: <20240913191037.2690-1-hpausten@protonmail.com> <20240913191037.2690-6-hpausten@protonmail.com>
Subject: Re: [PATCH v2 5/6] dt-bindings: clock: xilinx: describe whether dynamic reconfig is enabled
From: Stephen Boyd <sboyd@kernel.org>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Harry Austen <hpausten@protonmail.com>
To: Conor Dooley <conor+dt@kernel.org>, Harry Austen <hpausten@protonmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Michal Simek <michal.simek@amd.com>, Rob Herring <robh@kernel.org>
Date: Wed, 09 Oct 2024 17:51:48 -0700
User-Agent: alot/0.10

Quoting Harry Austen (2024-09-13 12:11:37)
> Xilinx clocking wizard IP core's dynamic reconfiguration support is
> optionally enabled at build time. Add a devicetree boolean property to
> describe whether the hardware supports this feature or not.
>=20
> Since dynamic reconfiguration support was previously assumed enabled,
> introduce a property to indicate the inverse, in order to maintain
> devicetree backwards compatibility. Hence, this new xlnx,static-config
> property should be specified when dynamic reconfiguration support is
> disabled in the IP core configuration.
>=20
> Signed-off-by: Harry Austen <hpausten@protonmail.com>
> ---

Applied to clk-next

