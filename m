Return-Path: <linux-kernel+bounces-297605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 196C495BB60
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 18:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0618B28DC1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273A91CCB35;
	Thu, 22 Aug 2024 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b="IiOdQCtl"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBB31CCB54;
	Thu, 22 Aug 2024 16:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724342818; cv=fail; b=sCcl/GnYDDV6czL3TDCcITGq6LT+L8Ne67kT3G1LdqgvtxNUHcAUmB2lun+ixoJO/h3bUYuWxP7xoUWktvBbLXfWhJ7oP4KxTbqJTgvyYB5+6CC+8JY13uJQOsrSSq1IpAl2bktVDT0z3LmjdEefrN/POo7FuReEUvzgwOErumQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724342818; c=relaxed/simple;
	bh=szhiMziUhwaGgaXmBpgFym+971vjqi0D7Sei4IljdYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mS7UypqSe9zGG9vlGOErHVe01Mc0sRSkrLvM2cX0+GUOIVOKVXR9wliHmpdYbn5gec4FxIpoV1mJGBaseqCzxrACfbNvtm0pWpThVjyMlWOWtL5pHGJOok7TTo2fi0T+JE+Sx9CfaCfyzCv1FTjJ5OKb/hN9minYP1GqCePXoXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=fail (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b=IiOdQCtl reason="signature verification failed"; arc=fail smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: angelogioacchino.delregno@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724342797; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OhKSG5vD8zTqFxCWiUl939PMcq1y48WA22QvvGEuDbpgijj5N2ppSwWR4N4F2Rr+30HtzvJSK2cUgdlddAXK3+aGm7Y1N9znVNNbl/aZydonZeTHopWdaBhLN9ncVlHV2ljQAuKOHgAPTWvXJEPUn90+uj3IgACEFeyO62ULfww=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724342797; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=87tmlEsafAzofaY1NSGv3qtcgJLjPPfLzmQEl9/8F0A=; 
	b=jhF31cqoR7O8s++GB+a2HDMnjCnOQH9ETIcdtn3PcjmlesTGzGbdCtPyYhdDtQ9H8gt1YqniUSjEiZtmpLgnLfdWJp3YdG9eM36wEt8yojHSxDg9FKIWRd6YtQ5nUtFWtutv/kf5XLj042qo/8NWTUDZBs1MHkAAAOp/SCq8TU0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nfraprado@collabora.com;
	dmarc=pass header.from=<nfraprado@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724342797;
	s=zohomail; d=collabora.com; i=nfraprado@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=87tmlEsafAzofaY1NSGv3qtcgJLjPPfLzmQEl9/8F0A=;
	b=IiOdQCtl4ydhm6JZ17+vy+2AW34dFmBecENcFxD+RkyMDd0bUHMCglExIoeTChTu
	lphYP9EC7nOoXwTf/9xC3ND/TOyvdx9JE+mmrdxrHLPPWG4+UENuRMezwCIvR7XHw2I
	85qNfHVQ6eb2WS8Bt+WuLi37hlCMKbWAVEOKa7Aw=
Received: by mx.zohomail.com with SMTPS id 1724342794590410.25595519500223;
	Thu, 22 Aug 2024 09:06:34 -0700 (PDT)
Date: Thu, 22 Aug 2024 12:06:31 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Rohit Agarwal <rohiagar@chromium.org>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com,
	daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, ck.hu@mediatek.com,
	jitao.shi@mediatek.com, dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/3] arm64: dts: mediatek: mt8186: Add svs node
Message-ID: <545e9e80-5b38-40f5-9a23-ff5112b13917@notapiano>
References: <20240822064650.1473930-1-rohiagar@chromium.org>
 <20240822064650.1473930-4-rohiagar@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240822064650.1473930-4-rohiagar@chromium.org>
X-ZohoMailClient: External

On Thu, Aug 22, 2024 at 06:46:50AM +0000, Rohit Agarwal wrote:
> Add clock/irq/efuse setting in svs nodes for mt8186 SoC.
> 
> Signed-off-by: Rohit Agarwal <rohiagar@chromium.org>
> ---
>  arch/arm64/boot/dts/mediatek/mt8186.dtsi | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> index e27c69ec8bdd..a51f3d8ce745 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> @@ -1361,6 +1361,18 @@ spi0: spi@1100a000 {
>  			status = "disabled";
>  		};
>  
> +		svs: svs@1100b000 {

There's already another node at address 1100b000:

		lvts: thermal-sensor@1100b000

You should set the starting address of the SVS to 1100bc00 and decrease the
iospace for lvts to avoid intersection. See this commit for a similar change on
mt8195:
https://lore.kernel.org/all/20231121125044.78642-21-angelogioacchino.delregno@collabora.com/

Thanks,
Nícolas

