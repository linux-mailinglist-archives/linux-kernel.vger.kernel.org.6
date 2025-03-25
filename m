Return-Path: <linux-kernel+bounces-574850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DE2A6EABA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 08:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04B1C3B53BC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 07:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D78C253F02;
	Tue, 25 Mar 2025 07:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="ysemAN5y"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D037A204587;
	Tue, 25 Mar 2025 07:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742888373; cv=none; b=MoNqZpuGB5w5xrodDizBigpTBnyyYmEZRzfuiyY1WvCzvg+lZFiIZXhG0hPdQFjF5YZV86TBbq5B5fJW2GEe4/MrF134lLniVPaKtcZ82FQY+34iTLdnIYRrsOi9HDFu6QED6Whjrt5iPhtriXJURO7r4HBPB2Q2TSL6Zvy0Frk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742888373; c=relaxed/simple;
	bh=batQneF++31YVzS6+Hca1+5CRWmi5MUZXOpSbDnq0wI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLsxdiJ/+k3wSEn817TN8kvuW8GlVDMjC8i/zJD2IqZMLU+wzj1p472lcgmwtHjCXWBJUM0gIj3aba3dDgqAt9zwHn+h6SmTTJ7Ktpj7DWiKVmen9D8T6cx+ohEPufkxEVQb5FhdyU4SNz9bWE7ObhAHivjCfOLOeDuEh+8I154=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=ysemAN5y; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 40E451F83F;
	Tue, 25 Mar 2025 08:39:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1742888360;
	bh=/HGvvkUO5PI2lhLwqNWFUyi3tDt6/UQpdwEBa8XWbrc=; h=From:To:Subject;
	b=ysemAN5y7zQf5M11vmEarU5i9KubasQV2MDpOX7Etq22Ey3B8M4DrC8roLpD84+5P
	 Q6E/n07U+wQJvlhMnnPVBDaPCOLgoXbBazpDYXwr+MdRtZGVWoDDBkzEMCk9pYZZpy
	 bbQUBaPIZhWPjEyUZLpZWTAK8wz93QqDlmMjCBlnBcCTxHrxXX/9qE7pMxk7Ha7ZaU
	 Q+pu8nOlCjYMudptUbckwwzk8K+sPYOvmCWMpauakoC8yDOQ+c2hWJ/pREKRl6GpVY
	 yMt+pgdozStgO3CYDDGvmfP42f11NKVMKeu4edkMV81hsbxEhQBhqTKG6lR5nxQYTX
	 /edp9QyvweNNQ==
Date: Tue, 25 Mar 2025 08:39:16 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Marek Vasut <marex@denx.de>
Cc: linux-arm-kernel@lists.infradead.org,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Joao Goncalves <joao.goncalves@toradex.com>,
	Joao Goncalves <jpaulo.silvagoncalves@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Max Merchel <Max.Merchel@ew.tq-group.com>,
	Michael Walle <mwalle@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, Tim Harvey <tharvey@gateworks.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: imx: document i.MX 95 Verdin
 Evaluation Kit (EVK)
Message-ID: <20250325073916.GA4684@francesco-nb>
References: <20250324234013.140440-1-marex@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324234013.140440-1-marex@denx.de>

On Tue, Mar 25, 2025 at 12:40:01AM +0100, Marek Vasut wrote:
> Document support for i.MX 95 Verdin Evaluation Kit (EVK), which
> used to be the Titan EVK.
> 
> Note that the SoM used in this EVK is a derivative SoM from Verdin
> line of SoMs, an actual i.MX95 Verdin SoM is under development.
> 
> [1] https://www.toradex.com/computer-on-modules/verdin-arm-family/nxp-imx95-evaluation-kit
> 
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Francesco


