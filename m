Return-Path: <linux-kernel+bounces-551956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1573EA57366
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E75F177C15
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 21:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA54C256C92;
	Fri,  7 Mar 2025 21:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ytm7P2hZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1399A18A95A;
	Fri,  7 Mar 2025 21:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741382190; cv=none; b=ZJf1QtsQzrNxlC+wtvyXZiFJUCDAdxstj5E/4nuWlncZPEuf6JyFWyx03uJ7YUtV1xbXrnABfqT25qKFPg/BxUMBE9rxmLP2EE6kMi+mXt3TYa3EdMD9nwrxVoksLruW6KltC25BmEei03Wc2VIkmZFnJVEeU/daWe7x/bClu5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741382190; c=relaxed/simple;
	bh=6aVpZFW4tHxOAaUitb1GesMT9DiFjftuQE+6p0UOB/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjxh4rqmSYb6sjtG2wR5Vg4hXLs3arC6kA/cX7nnqZIUT+qBEhhg6gOi539aBXnVUCEsxSTJDEkUKtv7aVDEhqQ5LF7u9uJ6bL9V47UqrX1mZldeCoSCsn4rhJYBLenMUXcV+9FEM8c0rl6u7R6roVmZshLelfUzFWvT1L2EfbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ytm7P2hZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536AAC4CED1;
	Fri,  7 Mar 2025 21:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741382189;
	bh=6aVpZFW4tHxOAaUitb1GesMT9DiFjftuQE+6p0UOB/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ytm7P2hZRURzdJ+MU/yAIFDZSb+UrdpuCgMMNA+gp5StPf09sk47cIYEtNcl10w/N
	 xh9SDbphksavDOZuQ2QC+5X1/okH1S3pkn9k0GeJaAFDdwElork59YXyBVbqgYK8fZ
	 yOFUBLzLEUMZW7QGnQY/j/mEOBo/q+6xMTojJ+fquEt2oKfkC8EbU5Jqh3AmQcAopt
	 J0MLPZSbE7j1NB6wiKuTHTmCQLDf33ojUtxDw9vcEtGuRVq/8YygfECX6aTuq5LZqg
	 EFxoI3HJPn5+UM1dK/7zg5+PPZqwn/DTuCGxok4c0Hg6IcXLvnH6uTS0nkiHqQ/z0j
	 h7XCowHyUAxNQ==
Date: Fri, 7 Mar 2025 15:16:27 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: kernel@pengutronix.de, conor+dt@kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	krzk+dt@kernel.org, linux-kernel@vger.kernel.org,
	shawnguo@kernel.org, linux-sound@vger.kernel.org,
	lgirdwood@gmail.com, broonie@kernel.org, festevam@gmail.com,
	s.hauer@pengutronix.de
Subject: Re: [PATCH] ASoC: dt-bindings: fsl,imx-asrc: Document audio graph
 port
Message-ID: <174138218697.627767.13339354154836355271.robh@kernel.org>
References: <20250306053138.1914956-1-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306053138.1914956-1-shengjiu.wang@nxp.com>


On Thu, 06 Mar 2025 13:31:38 +0800, Shengjiu Wang wrote:
> This device can be used in conjunction with audio-graph-card to provide
> an endpoint for binding with the other side of the audio link.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,imx-asrc.yaml      | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


