Return-Path: <linux-kernel+bounces-183261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 569268C9699
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 22:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87AA21C21FA3
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 20:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6518F6EB6E;
	Sun, 19 May 2024 20:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="I3/CS0fy"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C2250276;
	Sun, 19 May 2024 20:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716150491; cv=none; b=tgFDMnUvW52bdrFyjoOmfsxg0Jq2rejTIWUEZ2ujy1u/+I6eqMCgEdnFZ4dIXiPbH6VZ/q2zRJ4IguYfCj6pBbG4z13DxFkeOrLo7UGFpgDtDDdS7oUOsns6alorN84CjruQwn/y0dlOR+UYLgAhr9PF8Uk4Vs6pnBnV76M9JUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716150491; c=relaxed/simple;
	bh=ABGkxz9pvtLtNMl1tcRJRJ8GB0JrOkJ3EIfwiqAmmro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAbOgtHd/lR70lXn3QFsHG2jI1pBimUcQtrfGWwuWu/leZZR0jz95h1GjzMYS3fkggMjEsIBAG7cGUK1k2gGwtQ54Al0g51WAErMHKbtMqmJSFhzWTxjOKE1P+BUpRsRZhKe7K0YztKjodqf7mcoa66sdblpyY+w5UHMewhKuw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=I3/CS0fy; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 0F5D71FE0A;
	Sun, 19 May 2024 22:27:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1716150479;
	bh=YKZwnvA24IO6cuoLJk9uHKfxiFC6lne0yKR/X5F5Gpo=; h=From:To:Subject;
	b=I3/CS0fyVtC0KduerEKF0qMoA8SbLFyOMI1bbUG19e6ACSsRZYzXtkOCR15d2it5C
	 pFOlTfdPetk8VhKvzMHrpiJxEC0lZCF5HrBZLDvxApuVrgPNKyKK60KcwPXLu8fh9a
	 sNQxuGoDEaWAJTI7DSRYriS++Cnd1w7u52brIzyqRpibtSRqbWKVV4Vehg0dOQ88L+
	 8JkrF0lo3nWrpPKEa+IpRbpkEW9JQpQCjxjQ9NJtlsFrB2wJm88EhG4Ol463shWE5j
	 7/9AA5QZ50Hv6Qthzob8OwXvWGAjQfFSA/vu1WnqBSDIOFH9qa6hiZQtSW7EqPj28O
	 IwiJilZ8YNuxw==
Date: Sun, 19 May 2024 22:27:54 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Parth Pancholi <parth105105@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Parth Pancholi <parth.pancholi@toradex.com>,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: usb: gpio-sbu-mux: Add an entry for
 TMUXHS4212
Message-ID: <20240519202754.GA3334@francesco-nb>
References: <20240517111140.859677-1-parth105105@gmail.com>
 <1675a33d-47af-4de9-a0e7-177cbe208e2b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1675a33d-47af-4de9-a0e7-177cbe208e2b@kernel.org>

Hello Krzysztof,
thanks for the review.

On Sun, May 19, 2024 at 07:38:07PM +0200, Krzysztof Kozlowski wrote:
> On 17/05/2024 13:11, Parth Pancholi wrote:
> > From: Parth Pancholi <parth.pancholi@toradex.com>
> > 
> > Add a compatible entry for the TI TMUXHS4212 GPIO-based
> > bidirectional 2:1 mux/1:2 demux which can be used for
> > switching orientation of the SBU lines in USB Type-C
> > applications.
> > 
> > TMUXHS4212 datasheet: https://www.ti.com/lit/ds/symlink/tmuxhs4212.pdf
> > 
> > Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>
> > ---
> >  Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> 
> Where is an user of this?

The Linux driver (drivers/usb/typec/mux/gpio-sbu-mux.c) is using only
"gpio-sbu-mux", just in case you did not check yourself already.

As of now there is no DT file in-tree using this new compatible, FWIW
"onnn,fsusb43l10x" in the same file is not used by anybody. From some
old discussion here [1] (not exactly the same - I know, and coming not
from a DT kernel maintainer) I assumed that it was fine to send such
a change.

If it's not the case we'll send the patch later on, however some
DT files maintainers (e.g. arch/arm64/boot/dts/ti/) have a policy to
just accept DT file in which the binding changes are already merged
therefore I was trying to be a little bit proactive here.

Francesco

[1] https://lore.kernel.org/all/YgJjalw5O1aoBIX0@sirena.org.uk/


