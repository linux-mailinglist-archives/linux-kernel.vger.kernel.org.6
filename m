Return-Path: <linux-kernel+bounces-383796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF769B204B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 21:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82D47280CEC
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 20:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB9017CA09;
	Sun, 27 Oct 2024 20:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wt6XCzty"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FC379C2;
	Sun, 27 Oct 2024 20:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730060465; cv=none; b=fNW4WuOfjClcg2ZefRfjPvtGrL/aHg88iE60Gxoa/NlKPAEyrbDMdc7VLtFixx/6yP/80PN/DowwC04+uG3otAdunZRNQh/f557J7tU9N/R5PaQhziR2DW/uh3eGyq5UfYL8Sj9EvJ0qAU2tTkSyCLrCjuUQg7J0ozcgyBlJTk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730060465; c=relaxed/simple;
	bh=xvezVj/sIvzIzBVGypeNPYLR2yjJCCrKD12yNXgjiuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/e6mD0L8T1vhMODXV8JEzKbo2vNh4/rMDDosjZpDRuNlmWZHy46sORuLPZK7GK6HThoQiwY+twzIkaf6AoGofKO5i/BZF5opaw4EA/frX14rPYVP5q7PewbV5LABzBsWda7c4i5TE3OHsisd6zeCvrwtcdeG9VaFI8MX3yQqE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wt6XCzty; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3AE1C4CEC3;
	Sun, 27 Oct 2024 20:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730060464;
	bh=xvezVj/sIvzIzBVGypeNPYLR2yjJCCrKD12yNXgjiuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wt6XCztyTay62w8KVS9/vTBae5FnRkUq0Fes2xwo0T6MmRVg1Ma5qfe1L+1XdZUr5
	 59XXT1WY+jzQbINygk7aAM10uumxIUe/TjIfqBN2FenJYBz4Ai6GoazxmWtm1hZOl0
	 EudO1T9eT410JYKtY7JYJ1XUYiX07w6aOJ29g1ZLICfuXEEMR2KttJgkzeTHRmWtFc
	 CJR01lYrmlOkcM3slF2Yr1BsjwMfHQ0t1KArfjzmha6El97QFQZ/SHGKzRIu6dOuaC
	 qSKsyGzLnzsMvZutdu1XpFqWZQEZDb7Pmzm0R80WgMyjrCfClS8N7XlKvXdW2xyQl2
	 GY2prFMnRhwew==
Date: Sun, 27 Oct 2024 21:21:00 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, a.fatoum@pengutronix.de, 
	conor+dt@kernel.org, dinguyen@kernel.org, marex@denx.de, s.trumtrar@pengutronix.de, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 21/22] dt-bindings: altera: removal of generic PE1 dts
Message-ID: <qzv754tc3ir65y7357v26xzm33t3ypfhsrqoc2hb2ocjebkuqq@a4y3xopoysah>
References: <20241027143654.28474-1-l.rubusch@gmail.com>
 <20241027143654.28474-22-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241027143654.28474-22-l.rubusch@gmail.com>

On Sun, Oct 27, 2024 at 02:36:53PM +0000, Lothar Rubusch wrote:
> Remove the binding for the generic Mercury+ AA1 on PE1 carrier board.
> 
> The removed Mercury+ AA1 on PE1 carrier board is just a particular
> setup case, which is actually replaced by the set of generic Mercury+
> AA1 combinations patch.
> 
> In other words a combination of a Mercury+ AA1 on a PE1 base board,
> with boot mode SD card is already covered by the generic AA1
> combinations. There is no further reason to keep this particular case
> now in a redundantly. Thus the redundant DT setup is removed.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


