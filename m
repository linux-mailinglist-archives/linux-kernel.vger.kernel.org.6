Return-Path: <linux-kernel+bounces-216674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DA490A2D8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 05:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55912B210D7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 03:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD9F17E476;
	Mon, 17 Jun 2024 03:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="UeXh3GzG"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E342AD39;
	Mon, 17 Jun 2024 03:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718594672; cv=none; b=SUGy4Aa8UWIEiBy40L/BYrpazr9dhAtBotHieUk3tr2jmQ7sOKRoa7q3MSI7uq1JaeGjIOhH23UsT6FVLqYGh1iHtDan+x3D7ejQ4JasQJPg+EiHOVG2GHzCz7q4fg/DdBHAoeTYguYgC/AToIo3AaS8KeCnLKHHGa+JORSzROE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718594672; c=relaxed/simple;
	bh=XmFFDZ0f9GG1NAzOyKu4niTgTmQOFiMQSLaCEGZn8wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxLP6QYQVL7++Rij6vtY1sLmqlQyIUDJ4QvA0R1+6pHA6OxiaTKJy/ZEeS8BAM9e1IgtWxKBpuY5eU534DOHel4XPgI8zlrS1iyPUmofeTnvMBx9iStSvnnbGS2wz+/GyfNLtnzmtld19rBX0umxafuSKe4qlLtUbx3N3wTy5LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=UeXh3GzG; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=dWGjkuPaopuifvZBoMGZ2u+MVNe8w42W4DHJBlXPkNk=;
	b=UeXh3GzGAqMSmuA1TsOlFOh2AOb01dcMblHx7+df+KKCwK89GzjIbKil1BJT7k
	Qyp2eDUxT9gw88gA8kHUSXjnjTL9vIeG984PDQlN58JyPcQqu/xIgU8KhpgGyPDW
	OWRRXebJsG9t3PMW19ftWsML9Jxn9ZN1ZFwzJxWWsCuck=
Received: from dragon (unknown [114.216.76.201])
	by smtp2 (Coremail) with SMTP id C1UQrADn7xBXrG9msOjOCA--.52564S3;
	Mon, 17 Jun 2024 11:24:08 +0800 (CST)
Date: Mon, 17 Jun 2024 11:24:07 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Michael Walle <mwalle@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 2/2] dt-bindings: memory: fsl: replace maintainer
Message-ID: <Zm+sV8dJ+oCOwatg@dragon>
References: <20240604142249.1957762-1-mwalle@kernel.org>
 <20240604142249.1957762-2-mwalle@kernel.org>
 <364dc212-71dc-4bc9-b4fa-97ba2f92d679@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <364dc212-71dc-4bc9-b4fa-97ba2f92d679@kernel.org>
X-CM-TRANSID:C1UQrADn7xBXrG9msOjOCA--.52564S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWxWF1UCrW5Jw17Wr1Utrb_yoWxZrc_G3
	W0v3Z3uwnxXFZ7GF4kKF15XrW3Kw1v9ry5X34Fq34fXr90yr9xAwn5tr1fXan5ZFWjgFsr
	Cay3A34vk347WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8dcTJUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiGBgBZV6Nn47Q6AAAse

On Tue, Jun 11, 2024 at 10:49:36AM +0200, Krzysztof Kozlowski wrote:
> On 04/06/2024 16:22, Michael Walle wrote:
> > Li Yang's mail address is bouncing, replace it with Shawn Guo's one.
> > 
> > Signed-off-by: Michael Walle <mwalle@kernel.org>
> > ---
> > This is marked as an RFC because it is more of a question for Shawn if
> > he is willing to take over the maintainership.
> > ---
> 
> I suppose this could go via IMX SoC tree, so:
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

A second thought on this one.

Hi Krzysztof,

Since you are the maintainer for drivers/memory, would it be more
reasonable to put you instead of me in there?

Patch dropped for now.

Shawn


