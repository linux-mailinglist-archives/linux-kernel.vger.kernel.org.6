Return-Path: <linux-kernel+bounces-332932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDC497C0E8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 22:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33414B21FC6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 20:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FB31CB30D;
	Wed, 18 Sep 2024 20:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y64MSxR0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A3517E019;
	Wed, 18 Sep 2024 20:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726691836; cv=none; b=GCuLKuc27CTmaZRbbp4nYrbAc9icwcESQuBYkgqkD63neoFeMM8MqPkUVGWGhJnMUz2Xc+C4Y0859x6Jatd1erY8fihhhm/xP5LIoCSX05dxZThgq29JZUCo84ihU2Si/wfwmgA0BTQ9d6M4VNco1br0AtAkCF+RUA/jIM5TJvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726691836; c=relaxed/simple;
	bh=P78vK/IsWZQu9reqUe+AQv4u2RlxkViKpsnZtymZiNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9Ni2vchNKcpfplMD5S11h9cIfpe7MQoxmg+6E1pWLJGkPgH/LmC6H1R9k+OMKo4dm5vVqE+8s2umtB0izwuIlqY29UHwURdx9/asjt/fJ6hfWGfBAWm2YF5oggQnBTk7vzRvFtlkIQMWU2+DNX2cf1TzVDfYN5P56Sy+wenh8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y64MSxR0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75DA7C4CEC2;
	Wed, 18 Sep 2024 20:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726691835;
	bh=P78vK/IsWZQu9reqUe+AQv4u2RlxkViKpsnZtymZiNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y64MSxR0tHH5NS7qfJclCkouQxlL/KvtiGn53jMwBijoebZID5cb8Y36jB4RcGXod
	 sfzs4OlIQQOhiUPbwAifRAmYmjVPUYgt/Aq5+8fi+idd2/6mGDyaOJ+aULmWV9nO+i
	 YZfsfHMPc9akfe5CM9O+PadvepkqZjQdG4NxKJFHv9RsZxwlirlWZeGn7r/1E7+0Lz
	 KkOL1n4L84KnXwtk8R9Pjd6DsBL1mGg+WrBrjEmodGp8+mPHd8up65nqQIn07IRHmh
	 r/pscQ3dZ6RTBUqzqoI/3K3E1M8d2iKFhJIE6BbBbNVdqtODCLNMpVMRsM0/7oHp1J
	 zkZThye7vEgMg==
Date: Wed, 18 Sep 2024 15:37:14 -0500
From: Rob Herring <robh@kernel.org>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Iuliana Prodan <iuliana.prodan@nxp.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: dsp: fix power domain count
Message-ID: <20240918203714.GA2075709-robh@kernel.org>
References: <20240918182117.86221-1-laurentiumihalcea111@gmail.com>
 <20240918182117.86221-2-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918182117.86221-2-laurentiumihalcea111@gmail.com>

On Wed, Sep 18, 2024 at 02:21:13PM -0400, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

The subject should say this is for fsl,dsp, not *all* dsp's.


