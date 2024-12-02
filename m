Return-Path: <linux-kernel+bounces-427084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B529DFC35
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B38728210F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 08:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366A01F9F5E;
	Mon,  2 Dec 2024 08:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BewmDXEj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1D02940F;
	Mon,  2 Dec 2024 08:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733128990; cv=none; b=Xyrb+Jf/2G/c5Zj9A3drYdj+KsJEBOGsbCKs7jSrYSWlFx6PzIUnjufuWkyEJQ0aBlNiY7q1ANasdfwlSRERFg42iQBdSI1HJH8dXU2PIco7+COgDTubW/8/02uNPvmu/aS5q61HFSwtdIwChp81WO5ZqUK62IeGwqnB82Qal9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733128990; c=relaxed/simple;
	bh=01FuAxltFboSgbkGDbFpTK6260zYPeJejN9Ld7/Oa+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=utVy+jVjNufsj+ksUmV1MVZQB39h+wzeNEn8ovEfULVSj135ayCSgDWXbjDmop3GrDPvPBJbYL/nOROlHKM2kCzpI5hQJRRb1ERYlHDuan8i/ZPhviTcWTKffMY+d2ZdNISMpG0yxAvf0PvEVTJb6if7MZEm1Fr3i6CrRZN0PoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BewmDXEj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6750DC4CED2;
	Mon,  2 Dec 2024 08:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733128990;
	bh=01FuAxltFboSgbkGDbFpTK6260zYPeJejN9Ld7/Oa+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BewmDXEjnik5rDyz7I6LePOM/9876awp5O+bowTeGJFPpI+WurDcm8Av4gBQF9uXH
	 VlfYobB5syMpKVVkF9UsYzbkQCdU0LOb+vxL75Xs0bEAtqzlRdhU/bzvLbcdPGicB5
	 GMgddUnKfPjcr/zMwjKBsK3jK+9hZYXtvf0/WjMtn/fjrl5ohTwgpdkHzWUVnHyX/O
	 XmG6RQNBLAOT2ouAyTbwMuz1FMYCwwTLtDvJiR7iUNtZmRjEkqt41uO5oYJgHGhR5z
	 VEfcVmaZqc0E089XUHEoN7Y/TXiKgqANYQxx6OCfhyFOyyS0eMqlV3Phc+9d06lg87
	 kKHxUmaQEfkcA==
Date: Mon, 2 Dec 2024 09:43:07 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: arm: apple: Add T2 devices
Message-ID: <5ap2q5ok2jsqvft3puha6n4wmdc6tjtr5r52qdvblpiqz6t5ak@oas4a3vdikox>
References: <20241201161942.36027-1-towinchenmi@gmail.com>
 <20241201161942.36027-2-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241201161942.36027-2-towinchenmi@gmail.com>

On Mon, Dec 02, 2024 at 12:18:41AM +0800, Nick Chan wrote:
> This adds the following apple,t8012 based platforms:


"Add"
Please do not use "This commit/patch/change", but imperative mood. See
longer explanation here:
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


