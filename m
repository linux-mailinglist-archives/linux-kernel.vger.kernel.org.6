Return-Path: <linux-kernel+bounces-560323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B37FFA6024D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 21:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCCA77B019B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 20:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9924C1F4619;
	Thu, 13 Mar 2025 20:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oh/hUlRD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0021F3FED;
	Thu, 13 Mar 2025 20:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741897047; cv=none; b=hCpHi40Kak1lW4Nx4kMT6cXi6HnltAROKprT2+Y9RdMpeTFdtou3NgLwLLB9pEgWi3TJ6cckUUGGtnaTFjtCR6qoZrxfXv/6t0c0aJYqLjWPVtdKbAx8AlBu3zX1A3ouyDR9XCns5pc56CVEALsTh8Tf6Ow+IENM5dBxdIrQoBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741897047; c=relaxed/simple;
	bh=ZRWtB3rv+AKys/z8/S91KGoR6y3uP/Y1TIBFLbBQNwg=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:To:Date; b=G4SUWzqLu49x+/zO6/lGE87cUFavuJFsUb4ls9zTVSO4xoH8CMAn8Wea7pVsjUy7Wmkw21Wv77/ZoUHIXtQb4cWyCB5ZZEkeS62hh0Tn4S72/5ga8E8qmm1rjoNgJSPor1H2zaxkRpLrMiRhP7I6Pvgex7+oTBasMmV+GjiZMlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oh/hUlRD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54407C4CEDD;
	Thu, 13 Mar 2025 20:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741897046;
	bh=ZRWtB3rv+AKys/z8/S91KGoR6y3uP/Y1TIBFLbBQNwg=;
	h=In-Reply-To:References:Subject:From:To:Date:From;
	b=oh/hUlRDmMYFyWmn4VmL5tu5bi5jqC1dqBcqkJArjFHu5sH8vxz3fAmk6/Gx4cL6l
	 DUMvyNSapxbW3AXnKyEIYHNsZGI7wdrPqFtL+gAAaExVcuAJH1rnYDEMaHAwb5EcbX
	 Ivu1Mfg5u0rXOMiTpBUyULt374cgbf++C3oP/o+8xovzy73Jm3kQzKK7zlpqFk2mPA
	 +7NIQ5yPyWDj7LnC4pJB6xKivmMmdX9XI/qbhayVQ1WCn/syRGo0J59SoYWP8v2re2
	 fLd5F88vnGgVHjJkivUun96P/ALb3ZNHHbX4uLkLFo/CqVHmYko9hOetHF2kjh9Dwr
	 2JSF64C6qrwvQ==
Message-ID: <76a8bb40aa94465aa54233d191d142ef.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250311180215.173634-1-andreas@kemnade.info>
References: <20250311180215.173634-1-andreas@kemnade.info>
Subject: Re: [PATCH v2] dt-bindings: clock: ti: Convert ti-clkctrl.txt to json-schema
From: Stephen Boyd <sboyd@kernel.org>
To: andreas@kemnade.info, conor+dt@kernel.org, devicetree@vger.kernel.org, krzk+dt@kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, mturquette@baylibre.com, robh@kernel.org, tony@atomide.com
Date: Thu, 13 Mar 2025 13:17:24 -0700
User-Agent: alot/0.12.dev8+g17a99a841c4b

Quoting Andreas Kemnade (2025-03-11 11:02:15)
> Convert the TI clkctrl clock device tree binding to json-schema.
> Specify the creator of the original binding as a maintainer.
>=20
> reg property is used mostly with one item, in am3xxx also with
> an arbitrary number of items, so divert from the original binding
> specifying two (probably meaning one address and one size).
> The consumer part of the example is left out because the full consumer
> node would be needed.
>=20
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---

Applied to clk-next

