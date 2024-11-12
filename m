Return-Path: <linux-kernel+bounces-406576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6199C632C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 22:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF8EBBE5F7E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B31218301;
	Tue, 12 Nov 2024 19:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjG+l3P7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694061FC7D7;
	Tue, 12 Nov 2024 19:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731438072; cv=none; b=GmdjNuUAt/DEhSMqsPzdup+WuHrbx1fth1NhXRZ3/m1vjsJwTmo37HVGngzQNqOloCo3SzpoJ/fK8TTQVc3zC9YbQu/2BqZRrZDucvNig1A+BiO8Um0qEknSrCsMYOAs+jJb/xcSsO4h52TEBt2C5zr/wQmSIz6CiyfAPbWOZWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731438072; c=relaxed/simple;
	bh=WZwf962/9YxsL5mlzf/lgI57LwySIoZ+VuMBPM9dpUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OhmPESRrHLikDm88YWbrsua+5ojT0dmIMAk1C+VSawRWJftyliMGwKapH6eq/nGGSfMwbPYVOPA/EUr2iYoxTF+q57jNm3vhAXHTIuXj4H6bCR2KPr7BTlknLIXJxnJbehINhhlwbHwnxZmK1RdMnPdj3/tcGzyZnHhD7tyY1dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjG+l3P7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA88FC4CECD;
	Tue, 12 Nov 2024 19:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731438071;
	bh=WZwf962/9YxsL5mlzf/lgI57LwySIoZ+VuMBPM9dpUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EjG+l3P7gEjUYF2SJ3rm0dq4ZrU4SnjASasP5ZwrDkeNUPRNrsCszmGw4l2gKaUL/
	 KV6Tgic9snPkqxI6zpBEIEyPj/3JSlpRWnpYHDv/vc/UEB225Y5cYVJYi4pR29U8Vs
	 UqxR7e2dzo3Z+5WvAt9+8EQg67uu1eQHmPZ8oWwD+OD8UL1+WFaKWvZMTfXMQe/K+m
	 aMccBQEDy94thgZBEAHx5VzgbkwoClwAXnK2I1gIZVdURzOUw8j2FSDMlypuijAHqL
	 swa+uHukWNt9PECHxeUBbP3FMRAJDOjT+vFWo4rkBDMagEgdh0oDi/1IEBLnaI5R7T
	 Z5C0C09sZLBhg==
Date: Tue, 12 Nov 2024 13:01:09 -0600
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 6/7] dt-bindings: trivial-devices: Add Injoinic IP5306
Message-ID: <20241112190109.GA1518694-robh@kernel.org>
References: <20241111074720.1727163-1-csokas.bence@prolan.hu>
 <20241111074720.1727163-6-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241111074720.1727163-6-csokas.bence@prolan.hu>

On Mon, Nov 11, 2024 at 08:47:19AM +0100, Csókás, Bence wrote:
> It is to be handled with the rest of the IP51xx/52xx family.
> 
> Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>

