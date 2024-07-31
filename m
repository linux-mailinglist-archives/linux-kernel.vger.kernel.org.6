Return-Path: <linux-kernel+bounces-269912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 848F0943891
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 00:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A7E61F21927
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 22:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB0C16D4E5;
	Wed, 31 Jul 2024 22:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMVenu1t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E3915FCE7;
	Wed, 31 Jul 2024 22:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722463307; cv=none; b=XhU7FMcJ+zKkdFh3MUZtKqYC3XLeStRO3mD3a+Xe6cv44w3vcSdYK92lgKpzbC0c5ZH09bDlrAWXBa7NJJwuhRqoy1DnL94ImKeuYyeTCtcqPdQfx4rAeaWDmfpIvg8BdZoH64icHj5/vUJeKZrGjMGgtvwH1fidmxRBLsBoTNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722463307; c=relaxed/simple;
	bh=afxucK9AQbcFCb1YX26mOx1e9csVC/4lhni7ThTmIfs=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=oSmv/hJVFX9pUd0UNOSeQfCgjmp3HhZJm66NBQwbIaaVXaXHvy22w69KNXBt4GliqevMCccev5isY8YV2/1lcMLiswyOg067xGdBLAe5AWf9IGM8n6iRdxXHKExC7Ek4pPJqXYEjSUszOTVNiK59muzZ4P7aeGyEV8eeYL09IRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMVenu1t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C88BC116B1;
	Wed, 31 Jul 2024 22:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722463307;
	bh=afxucK9AQbcFCb1YX26mOx1e9csVC/4lhni7ThTmIfs=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=GMVenu1t6JyLp6PSMm4mBW4MhRqaJOu2kz5VtR52+LzzPHnuwwoVhCQrmTv8JStgm
	 gvI8eX1r3PTaverND3GbuDz1QgnhUpE8UvjlkSWh38UTmbbdSyo1+zy6swsDEnTahc
	 VqC0msHh14X7b/Yt/1ePLShrOyzxI9tHqSzPOIUaUAHG9m8fGK/l6G8pCNWh8aotLK
	 vwbRZhQpUJRg4thPlPteNCc+CPFWGYkpwz92qe8VOXtoFF67Fyxh4ZPKgaigLscRO4
	 7mZ+F4+Sog0gRzGVH8Syz8ULLOMKCzopBEMNdbKjvL45BiJAhr9Aj0Ap4T3ygG9chf
	 1344w2iTw8CIg==
Message-ID: <c0028487ce1098167f46fd3b89a0a637.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240730141338.46234-1-animeshagarwal28@gmail.com>
References: <20240730141338.46234-1-animeshagarwal28@gmail.com>
Subject: Re: [PATCH] dt-bindings: clock: nxp,lpc3220-usb-clk: Convert bindings to dtschema
From: Stephen Boyd <sboyd@kernel.org>
Cc: Animesh Agarwal <animeshagarwal28@gmail.com>, Daniel Baluta <daniel.baluta@nxp.com>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Date: Wed, 31 Jul 2024 15:01:45 -0700
User-Agent: alot/0.10

Quoting Animesh Agarwal (2024-07-30 07:13:34)
> Convert the NXP LPC32xx USB Clock Controller bindings to yaml format.
>=20
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
> ---

Applied to clk-next

