Return-Path: <linux-kernel+bounces-273943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCF6946FF9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 19:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77EE9281376
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 17:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC861311AC;
	Sun,  4 Aug 2024 17:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2eZt3ov"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6C61EEE3
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 17:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722791404; cv=none; b=WP8LYP3XpBEwvRGNF6fO7biKBYTajPayWNty+QegMwi7EcDs602thV/Gjns+Fgnr3mvNY0O9tyXMBV45kweP76CP/tm2fefrI35I4ZQcG5/KTO4ufMVdYIhbo8cbAmQz4vFiOPH2Up3ZXMgDaZv9DCRqOA/SS/bTfhSLu1A41NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722791404; c=relaxed/simple;
	bh=Qoe2GLfyjnH5NIkm5TFRsZ//1kF1br9F+560psv26Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQm+kJTO5q+4a3mDZ+9hmht5FxiloY3nMxYxDXUC99rGBNbd9PVmX3+5Tgf5oqKdp9/PPtr1frVCBDThwuY1OlfyRznNfVHbgEitcy0UnCYVZCtoqilEPBSHkoBfNUn9PoR7fEloZMNRMLss89qOy1bOjm2e52zPPAyuNl1QUWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2eZt3ov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C833C32786;
	Sun,  4 Aug 2024 17:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722791404;
	bh=Qoe2GLfyjnH5NIkm5TFRsZ//1kF1br9F+560psv26Xw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d2eZt3ovf1xtNnptv5RwmsyhUkWmyi7j8mQq063GxsJYGgraakhNdwvn5cm5l6Y1N
	 87YquAhqL6BO6hKATi/FsbByfzC+siMm1LNI/e9dzgTxXFZUb/as4xXd0fEaGtkmuJ
	 quuWQWKnpxPue7ic4B2u5mRRAbPitlnJr95W/BLQVR2WCUMSzlsXwe+JIL/SPFm1C7
	 pZA8bq9bpuk7pw+SzHQz6Eu7dsOiTxJP1DtWpopHgsDAH+CecLgIsWphGDWJm7lFOh
	 3uTZQ/gIDU190LseusFb+r/fwR9DulYeE1ua8pPMfaIcNH2b932UaGbBYusWpoq61g
	 9sSyk3bpCF9bA==
Date: Sun, 4 Aug 2024 22:39:59 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: kishon@kernel.org, p.zabel@pengutronix.de, sjakhade@cadence.com,
	rogerq@kernel.org, thomas.richard@bootlin.com,
	theo.lebrun@bootlin.com, robh@kernel.org,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH v3] phy: cadence-torrent: add support for three or more
 links using 2 protocols
Message-ID: <Zq-15_enK919eUg_@matsya>
References: <20240716102442.1605280-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716102442.1605280-1-s-vadapalli@ti.com>

On 16-07-24, 15:54, Siddharth Vadapalli wrote:
> The Torrent SERDES can support at most two different protocols (PHY types).
> This only mandates that the device-tree sub-nodes used to represent the
> configuration should describe links with at-most two different protocols.
> 
> The existing implementation however imposes an artificial constraint that
> allows only two links (device-tree sub-nodes). As long as at-most two
> protocols are chosen, using more than two links to describe them in an
> alternating configuration is still a valid configuration of the Torrent
> SERDES.
> 
> A 3-Link 2-Protocol configuration of the 4-Lane SERDES can be:
> Lane 0 => Protocol 1 => Link 1
> Lane 1 => Protocol 1 => Link 1
> Lane 2 => Protocol 2 => Link 2
> Lane 3 => Protocol 1 => Link 3
> 
> A 4-Link 2-Protocol configuration of the 4-Lane SERDES can be:
> Lane 0 => Protocol 1 => Link 1
> Lane 1 => Protocol 2 => Link 2
> Lane 2 => Protocol 1 => Link 3
> Lane 3 => Protocol 2 => Link 4
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> Hello,
> 
> This patch is based on linux-next tagged next-20240715.

Sorry this does not apply for me on phy/next, can you rebase..?

-- 
~Vinod

