Return-Path: <linux-kernel+bounces-373969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C98E9A5FF8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E2B5282606
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A471E32BB;
	Mon, 21 Oct 2024 09:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="hZAPVk0B"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460A81E1C0F;
	Mon, 21 Oct 2024 09:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729502879; cv=none; b=suzxlRGIfH3IAhgOoy45eP8sd1RaHVIClRlx4GymGd1OBX1HGYk3Rp3OOZkkGUoqp0h4ddq0psPMpLXKMPvKtqll9Wp4uhL7aaxyLJB/9y77D3kzgRV7WEEI+C54aQACl4+zKgfF1Jknt4ZW3myQ+tyNMAG9KRuX1gOyUVMPdqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729502879; c=relaxed/simple;
	bh=ll7At9nIH9NUcF3cfpSsh7DnwpHJyoRpUcmDz8PvqeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RryTYIaNmxABkE108RzUL8VLEXQUzVqIumzpuTRAy4KUuFHaMev56JOBnlI6MMzpsVA4q08DfAl1rO0f/TolT7XbxKTq52WMtk2pecQA6moZO0JeLVI1FV/Y6+9DGQiqc+qZdBW7LSwfCEYWwk3uf8DYj+68phLKULTblM42GIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=hZAPVk0B; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 4F6A01F910;
	Mon, 21 Oct 2024 11:27:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1729502867;
	bh=mSgpzAFgc/z8kyQlEP+bYSHF4QmpnixYUN3WVSsK7sE=; h=From:To:Subject;
	b=hZAPVk0BpGHOPRa87cRaWp3nX9mkTjq4rVaSOFaEpg6pLB1SWACbmRkUUA3i5M2s8
	 4BHJnNURc2wYCo413nuyAI8AEMkYksjXqHQ/oX5u24jVgAUKptClzfMW0tkZBOkAOy
	 jT1G8BA2F6bSfZ/0ZOSl5qZEdu3SszIlY97HpJHD4Ya8RWdzpP7W3eUu/Yy+z/C1Gu
	 ownS2rjyZ7Z4i8OLavxbqdrxTeG4PcrBiIpIaR+6AR2YiA5Fs0jPoxDCEXoPqQieKY
	 WYkii8iaSwPaNMMiaGzFkLKdCGFXldMD4IPh42U6oWIg5ZWWtvjw+aVuYRgNaFpzA7
	 7ittoMivMBVDg==
Date: Mon, 21 Oct 2024 11:27:43 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: carlos.song@nxp.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, frank.li@nxp.com, haibo.chen@nxp.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx7s: change i2c compatible string for
 applying errata ERR007805
Message-ID: <20241021092743.GA21104@francesco-nb>
References: <20241021031148.2682015-1-carlos.song@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021031148.2682015-1-carlos.song@nxp.com>

Hello Carlos,

On Mon, Oct 21, 2024 at 11:11:48AM +0800, carlos.song@nxp.com wrote:
> From: Carlos Song <carlos.song@nxp.com>
> 
> Compatible string "fsl,imx7d-i2c" is not exited at i2c-imx driver
> compatible string table, at the result, "fsl,imx21-i2c" will be
> matched, but it will cause errata ERR007805 not be applied in fact.
> 
> Replace "fsl,imx7d-i2c" by "fsl,imx7s-i2c" compatible string in dts
> file for appling the errata ERR007805.

Did you considered changing the driver instead? If I understand this
correctly it would be a better solution.

Francesco


