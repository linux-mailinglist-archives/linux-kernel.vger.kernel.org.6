Return-Path: <linux-kernel+bounces-353555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C52992F6B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 156EB1C22773
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C981D8E08;
	Mon,  7 Oct 2024 14:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="TtvtK9rc"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076831D8A0B;
	Mon,  7 Oct 2024 14:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728311370; cv=none; b=eJI2xfeUIxAFnZVWhH2hdaohXtCx13bMbsS9B1KD9cMxJSuyDBPzCZ1w/E7/er8Yb0ENVctMeT7Brkc7BfbJVPxXsK3+eyd4tjhyoAMK8CQIaa0QN0BLckk6g94G2i0SsSom64c/7IMGuHaWqfm37Xwz2yKrSrNg0SKJIOxnWVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728311370; c=relaxed/simple;
	bh=MUEHCdKh3aJ5JqNifbPS8ENpMQSLR/6AYBe3Pc4AvcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yr69nJynmZi7RTBPXKl3TsXf1PZ4m95ldnts9TzVmbgxMOpP7+1vjKou4oG8rkfm9da396tJvTRfkDKzDP3Hd7vJEJzNZQoMARSuC1b+ZAPcP6jo5iyi7McR0nq9+sH3jMPxG85UvCeD4K2ZzQwfJhYVbGywE+NO8gnvGFW1Ers=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=TtvtK9rc; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 6EFD51F9DE;
	Mon,  7 Oct 2024 16:29:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1728311364;
	bh=sOHjT9wpAB5MT/e6tMUBafhY6CRxXTHGsGrCQWp+3xw=; h=From:To:Subject;
	b=TtvtK9rcn0sjN6KhgYDsjIlXY+cSp+kVfMEtbDnVmrFzJkT0aQ8tlHQ9HniVUsGP8
	 +y/yiT+tuUS276VbPQxXuU5Nblnk1QnzwvQeKuTVCDsySdyhRagn74gUO+GmBuPn/y
	 hxlh/Rb7o1bW0lxP/qDuaEZupV5zBkVpYM3OXgeVpdsKduW8UgrRYGUUjsj3kKWZ6G
	 1tPRtigLpriqL3a9PsoFZ/6V8Wbd/WM9yXVGEb5MCbh68ZSRQE8ttA40RsxF1d6w6M
	 lpYfdE+hkYUZN0d0rNZcdgIc3npP+enEwP/GaC3p7kt5Y8VfgEjhZTJgipMMHe4RjO
	 LtUIKZkG29oPg==
Date: Mon, 7 Oct 2024 16:29:20 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>, linux-kernel@vger.kernel.org,
	Parth Pancholi <parth.pancholi@toradex.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-usb@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: add TUSB73x0 PCIe
Message-ID: <20241007142920.GA60623@francesco-nb>
References: <20241007093205.27130-1-francesco@dolcini.it>
 <20241007093205.27130-2-francesco@dolcini.it>
 <172831060758.15259.15265542019562102842.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172831060758.15259.15265542019562102842.robh@kernel.org>

Hello,

On Mon, Oct 07, 2024 at 09:16:48AM -0500, Rob Herring (Arm) wrote:
> On Mon, 07 Oct 2024 11:32:04 +0200, Francesco Dolcini wrote:
> > From: Parth Pancholi <parth.pancholi@toradex.com>
> > 
> > Add device tree bindings for TI's TUSB73x0 PCIe-to-USB 3.0 xHCI
> > host controller. The controller supports software configuration
> > through PCIe registers, such as controlling the PWRONx polarity
> > via the USB control register (E0h).
> > 
> > Similar generic PCIe-based bindings can be found as qcom,ath11k-pci.yaml
> > as an example.
> > 
> > Datasheet: https://www.ti.com/lit/ds/symlink/tusb7320.pdf
> > Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>
> > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > ---
> > v2: rename property to ti,tusb7320-pwron-active-high and change type to flag
> > ---
> >  .../bindings/usb/ti,tusb73x0-pci.yaml         | 60 +++++++++++++++++++
> >  1 file changed, 60 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.yaml
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.example.dtb: pcie@0: usb@0:compatible: ['pci104C,8241'] does not contain items matching the given schema
> 	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241007093205.27130-2-francesco@dolcini.it
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade

I do not have this error locally, and I am not sure I see the issue in
the yaml file ...

$ make dt_binding_check W=1 DT_SCHEMA_FILES=ti,tusb73x0-pci.yaml

...

  CHKDT   Documentation/devicetree/bindings
  LINT    Documentation/devicetree/bindings
  DTEX    Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.example.dts
  DTC [C] Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.example.dtb

$ pip3 list |grep dtschema
dtschema                  2024.10.dev5+g0934678abc36

Any idea?

Francesco


