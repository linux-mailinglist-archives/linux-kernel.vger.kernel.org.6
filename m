Return-Path: <linux-kernel+bounces-248386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D2092DC82
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 01:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 131DEB21D8F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 23:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F073153BDE;
	Wed, 10 Jul 2024 23:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nefAygc3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF5914B082;
	Wed, 10 Jul 2024 23:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720653473; cv=none; b=cgfXYfNI9bPonY4h1u63iQfIcr44LZ4usMCZDDqwbI7M2BmJ/LlpRtecLpwFFV+E2gfU2NkFLKImdBShaq+ZSum0wXIcKX20wLBDLTZIDDZl0VVqef6VTEwMCJ/fNFXFmxg8Ctw2Hfnt1OrGnvw3FzAD50Stb4T6mDpS+Z4e8Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720653473; c=relaxed/simple;
	bh=67AV/g+XqsyhDAFqbAi12LGCJ7fOFWXjzSEQ2K49hOs=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=hZGVum6HbMafRCSkzNT0Atv+OS4OlVa4jqBuGAjqxyt0do1thryH1n0kwird0MW2je0TQ3TQNQRK0srSTIcNug/0lW/3DEq0fdqvuIYBVJ8NJgOIZVUWzBZBhnWvwJup1KEJNn+RBYUGpW3Ec7T7pdBn9/Y5/YCR3oT5MZycOjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nefAygc3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC90EC32781;
	Wed, 10 Jul 2024 23:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720653473;
	bh=67AV/g+XqsyhDAFqbAi12LGCJ7fOFWXjzSEQ2K49hOs=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=nefAygc3iGJngyPBt92Z+opttJ4pacy7p94Mca6aQ5dkVGqItLy2nbdt21J4IgNfm
	 fn3+TnIohJNmhpurRk/T+vtr1w7mtn2zyFJQh2Qk36+aMO+822V5H0fVFNjKcXsrIc
	 NyJjzNAbM6RSyzDd6q0FkdmB9ck5ogeMhXsf5IpvF/EKQVpvGJMA8ly4YXcgxqbIOt
	 dfTHBaSLRTUHwqdVn1qHmZ3q4fyKzOjTPbjp2bSZ0o5SOjgE0e8bfXyD7+F2OWoID0
	 2i4j2IM2Ud/3yvWwscI7+6o7P7n0ThMklJErgg7Hmd8DiNULJiXJWBIT3XeRMtets6
	 T1QD6f/6uvgCQ==
Message-ID: <57ef2eef45f2de15e6607da266b37b2a.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240623-th1520-clk-v2-1-ad8d6432d9fb@tenstorrent.com>
References: <20240623-th1520-clk-v2-0-ad8d6432d9fb@tenstorrent.com> <20240623-th1520-clk-v2-1-ad8d6432d9fb@tenstorrent.com>
Subject: Re: [PATCH v2 1/7] dt-bindings: clock: Document T-Head TH1520 AP_SUBSYS controller
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Drew Fustini <dfustini@tenstorrent.com>, Conor Dooley <conor.dooley@microchip.com>
To: Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor+dt@kernel.org>, Drew Fustini <dfustini@tenstorrent.com>, Emil Renner Berthing <emil.renner.berthing@canonical.com>, Fu Wei <wefu@redhat.com>, Guo Ren <guoren@kernel.org>, Jisheng Zhang <jszhang@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Rob Herring <robh@kernel.org>, Thomas Bonnefille <thomas.bonnefille@bootlin.com>, Yangtao Li <frank.li@vivo.com>
Date: Wed, 10 Jul 2024 16:17:50 -0700
User-Agent: alot/0.10

Quoting Drew Fustini (2024-06-23 19:12:31)
> Document bindings for the T-Head TH1520 AP sub-system clock controller.
>=20
> Link: https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs=
/TH1520%20System%20User%20Manual.pdf
> Co-developed-by: Yangtao Li <frank.li@vivo.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
> ---

Applied to clk-next

