Return-Path: <linux-kernel+bounces-370680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA759A30A5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 00:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4F97283665
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 22:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1301D7E35;
	Thu, 17 Oct 2024 22:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p6NkfUH2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7255F1D54E9;
	Thu, 17 Oct 2024 22:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729203902; cv=none; b=I1gQmLzv4NiD7R164gFATHixSbj9u8bF8NSVNttk179nYiPJyhOxjvboZ8dV8lWonav5rzijvGEFFj2HT5jWCzlKfYr/j53mqu81NhMIERCAHy6Lm7pbAZ4awWj3q4yTIZWmQZO9VHum52hbFQRuTM0Btu3sauCA8gPSsXyxWz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729203902; c=relaxed/simple;
	bh=UxsMeMKqTAaNxfn5AaD4HqHVdbM0GZp5OXnjQx+h7c0=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=TpCCbJKn1A9cryJ/KOoNv7h4VuGmVCrHGnbsM/boS9BmZ1nD4enfCI3safe3ATFVkRt3La4PDk2AMrapiwNUErsvNBqsBCSSek1K6k/P58h98TlXnXxn0B/yuKNcGpEKezqSNz8W1gM+UqQRaoezq1fu7u0+9mzTLPh6rzkftIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p6NkfUH2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DEEC4CEC3;
	Thu, 17 Oct 2024 22:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729203901;
	bh=UxsMeMKqTAaNxfn5AaD4HqHVdbM0GZp5OXnjQx+h7c0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=p6NkfUH2iEdRK5kmbrFK6ylq+jIY9PF/KQoxiEzFAZdC25O/mvcI8MI/+/JFmWE96
	 CAO/Eb0hdbFhw3nXzoxHQwSfpYM2PERo46auNDpL8bw9rnpzSA5JzcMaHCMaryAQJu
	 z0FnhRaLpT3lW2a1MIH9le27Lad+PjekUlX682DGrHQtI1DcrjEkI6D6fkV5ht7PPC
	 MFSE3J3HMbIkwdM9Ehh4ehQW0sCf5yNhub27rJVjn9jTR9NfHUn/pMxCRVijLwrqQA
	 bUKJnC3yHLbx6GJ3uILBoCuU4CfrZ6IZIzKp2wtPvxOB1uh56WgDxCpajU0nxSuurc
	 KlPFmlOsexNVw==
Message-ID: <45f562afc56223014bde8defc132023b.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240927103005.17605-3-pablo.sun@mediatek.com>
References: <20240927103005.17605-1-pablo.sun@mediatek.com> <20240927103005.17605-3-pablo.sun@mediatek.com>
Subject: Re: [PATCH v2 2/6] clk: mediatek: clk-mt8188-topckgen: Remove univpll from parents of mfg_core_tmp
From: Stephen Boyd <sboyd@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org, Pablo Sun <pablo.sun@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Pablo Sun <pablo.sun@mediatek.com>, Rob Herring <robh@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Thu, 17 Oct 2024 15:25:00 -0700
User-Agent: alot/0.10

Quoting Pablo Sun (2024-09-27 03:30:01)
> Same as MT8195, MT8188 GPU clock is primarly supplied by the dedicated
> mfgpll. The clock "mfg_core_tmp" is only used as an alt clock when
> setting mfgpll clock rate.
>=20
> If we keep the univpll parents from mfg_core_tmp, when setting
> GPU frequency to 390000000, the common clock framework would switch
> the parent to univpll, instead of setting mfgpll to 390000000:
>=20
>     mfgpll                            0        0        0   949999756
>     univpll                           2        2        0  2340000000
>        univpll_d6                     1        1        0   390000000
>           top_mfg_core_tmp            1        1        0   390000000
>              mfg_ck_fast_ref          1        1        0   390000000
>                 mfgcfg_bg3d           1        1        0   390000000
>=20
> This results in failures when subsequent devfreq operations need to
> switch to other frequencies. So remove univpll from the parent list.
>=20
> This solution is taken from commit 72d38ed720e9 ("clk: mediatek:
> clk-mt8195-topckgen: Drop univplls from mfg mux parents")
>=20
> Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> ---

Applied to clk-next

