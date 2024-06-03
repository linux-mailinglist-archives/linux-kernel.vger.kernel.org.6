Return-Path: <linux-kernel+bounces-199796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD058FA606
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 00:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0005128C4AC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 22:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24A713CF97;
	Mon,  3 Jun 2024 22:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cv4ZXOWp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0E7F9E9;
	Mon,  3 Jun 2024 22:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717454841; cv=none; b=aUA6sPqkrM8Qop85o+xMjbA0C4g7Y1g8T+ETZtGdUK0nA17GucDZisaHXkjRPYVhfXAOnapZaaRdtzhNvI8lpO8lRSHTK4mp3ig7l5OVQ96Z1vUbUDyQkvUcBXKk/MYRzutU+cluvxfpLGsHIhIW68EigA8oINy6kvLRV2FOYkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717454841; c=relaxed/simple;
	bh=DEunokyrNaEDT2d/O3KKJyk3+DcOVUw3ikRMaRgGBrg=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=CkK//caStfbIk180Fyjs0EA71snYUG7D+vJ1Wu6qbWZJoae/M0EvMkIzyMkwbmI5iI6xDSTfY8jSB2IpeMHOfzfDyyUSxPYaB4VCGezwt0w3aQnxMIjLunzpuTh7O7VGvZj3tKAwa3KFxCNS4uSqJZC1P29dCtTlNYmBPDNjOBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cv4ZXOWp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F84C32782;
	Mon,  3 Jun 2024 22:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717454840;
	bh=DEunokyrNaEDT2d/O3KKJyk3+DcOVUw3ikRMaRgGBrg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=cv4ZXOWp1nK6xjrHJX1Q1uLMP5Sdi4LNFmK6Pf7I9NvQ6CFxOl4YOxndvCx2HpkpW
	 I4rqv+/encoYeBXkiQctekTnJyTvAre02DAYYdFiS+JsVKL/fLVe8wRvxoIFacP5kF
	 vf1WnlX04zXnciqtpzDFtrVPw9qQhmoIKI9rCSsqKnA3j43ATCMs+/FPoMdcvuyx8u
	 LPi8Hv7IRVrJevG5kcjQUO34CGI89H+jjyFI02qaaeAh7iEys3bHN8i0tCT+hm0Q1q
	 2tfEeh/zpiWxPUnfYeBM5r75s863ySFrDEpk/KYJyNfcQveQuKzrll8qnzBZThXgjf
	 3jnLS9oaKFeLg==
Message-ID: <228229d08b0293b31e52e604e10d9f54.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240602-md-clk-test-v1-1-a6afd4793337@quicinc.com>
References: <20240602-md-clk-test-v1-1-a6afd4793337@quicinc.com>
Subject: Re: [PATCH] clk: test: add missing MODULE_DESCRIPTION() macros
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Jeff Johnson <quic_jjohnson@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Michael Turquette <mturquette@baylibre.com>
Date: Mon, 03 Jun 2024 15:47:18 -0700
User-Agent: alot/0.10

Quoting Jeff Johnson (2024-06-02 08:38:33)
> make allmodconfig && make W=3D1 C=3D1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/clk_test.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/clk-gate_te=
st.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/clk-fractio=
nal-divider_test.o
>=20
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
>=20
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---

Applied to clk-next

