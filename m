Return-Path: <linux-kernel+bounces-338201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC789854AC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5866E1C20F85
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F43158848;
	Wed, 25 Sep 2024 07:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngCiuEyG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEB2158533;
	Wed, 25 Sep 2024 07:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727250972; cv=none; b=igBG3lnuYhpyPJ331NGMsXhpuUYhzCymjL1tCbHByDfCwzwS8PkWVUg7aOej/W0sCQ5HKBPlAUmFSXf/vmEoQOcq1+7xjN/J572laqodAT/Ec+ya0xTJVx/0mhEyYjjANNYccz0nGUWmrPBsbEPJSmD/3H2vvzP8Sp49C+qhPj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727250972; c=relaxed/simple;
	bh=M5dR0p6/zLMmQao2qvRx3Oetiq33fuzs6bbE8evcwPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rB7rFGyHk2EG7XQ9GpsloafpNMeeENyliiaj4gAEyW7ANtZTOJA9yISgqUO7BfEKIx1wKJhD96YcMAfOB5pQr47BQIgQ1NEj6xaceEdm7cPIVv38SII22whz7mP0vKqmDzyB1C6FVDY9J7knhFmIbC1OR848kXPf/S5e1o6JeX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngCiuEyG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA1EC4CEC6;
	Wed, 25 Sep 2024 07:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727250971;
	bh=M5dR0p6/zLMmQao2qvRx3Oetiq33fuzs6bbE8evcwPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ngCiuEyG53ZVEGTVeyyUsHTq18XwtHjLT4//omQ6L2ZlEPygs9aZdtge3wX7L5Z5y
	 zJzH1SQ16JXb7b3HHoVqam4tWR0ifOOoTInKILh5S7eb0twzuK2Osn0WzfrofD3Yp3
	 R1YNoUobQKFVUyQqwBG9pJkZXoP2fsBhML7uNeXr52p6Lb9SVmG4RKs+WJgsfOxdR+
	 HSeQqho0nrB08mrqQnfkgJq+TEyTKhZaakLb+Qxjl4bdgYeQsVPyhlLsce8K9s02OV
	 NDXrfGbQUxml9+/CAOt+1/qjTgiPX20zmeKWZtEKUs+JXaCN7G5fR9uqBicvx4fqme
	 871EeCD/usOTQ==
Date: Wed, 25 Sep 2024 09:56:07 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] dt-bindings: writing-schema: Add details on YAML
 text blocks
Message-ID: <xlqdjvch3m4q5p3qbkr6tpbhkttqf3l5c6elt6fa5lzrs63rcj@ohpbfr4pugpa>
References: <20240918195130.2024205-2-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240918195130.2024205-2-robh@kernel.org>

On Wed, Sep 18, 2024 at 02:51:30PM -0500, Rob Herring (Arm) wrote:
> The YAML format has a couple of different forms for multi-line text
> blocks which control allowed characters and handling of line-breaks.
> Getting this wrong is a common review issue. Either a literal block is
> used when there's no formatting needed or a folded/literal block is
> not used when there is formatting to maintain.
> 
> Add some descriptions of the different forms to point folks to in
> reviews.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof


