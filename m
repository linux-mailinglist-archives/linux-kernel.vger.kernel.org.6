Return-Path: <linux-kernel+bounces-174272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE8E8C0C61
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 10:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 673A91C215ED
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 08:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDAB149DF2;
	Thu,  9 May 2024 08:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k03KQNyz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9578B13BC3E;
	Thu,  9 May 2024 08:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715242645; cv=none; b=uqlGeUdcrgikeM5Z93HwHAr1TmMx8WeGUXz6xJKqyKuq8tPULSzx5VYlYa1o/XkTZJ5Nn8hjZvScit5hjIIECVpgE5A6AxDKFGyIma7FttikyaSCiF3Ea4YQzSefH07i31wQbCkBQ6zjWl2zTl4YYSaBMb/DMMqkGvPDHT3IywE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715242645; c=relaxed/simple;
	bh=y7knbMNhnUUEDsLf9YXpNk8Dd2rj+1U27Xx9O8RvkhU=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=PcrbJM5JVQ17lMRlbLwMEQX4VSvpx24qPo4XTZxtuhGBD71k/Y/GbJLHndtpH0+ceaGSlPLEP5bhXZZ0gLe4KDVXx+sohzEnKb80tpMB6pJzac0IRJ7aWUkL/s3XPcDtlNhgdIrBaRuM394QM/5KvDtWkGoFaQdsMNwvNsE8EmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k03KQNyz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7B2C116B1;
	Thu,  9 May 2024 08:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715242645;
	bh=y7knbMNhnUUEDsLf9YXpNk8Dd2rj+1U27Xx9O8RvkhU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=k03KQNyzI4Jgt7FTWXq2moOeRIeA91w0d7S0bl6Q3RBgiYz4hHTYnVcMHCpIcvKqW
	 TvyJASFu47clC3KwaBHVHxpLDNr0jg1xOPU15gh38ASkwcSGfpbx8+zXvm4dBhScdL
	 9dNzt5YTuI3dxP6WK1edT0NGhp0A2Zbms84mqJ0yi2BjymiGTtYgbEZq1Nj8z6sovV
	 G4wl0ogsM+o5Zh1BADjp9YU6VSF3sqEiuB0v6ofUlZfIacMZbdot2Mp9KZmuVe6g3K
	 OOlPkAfg9Rq2YJhJCJ9JHh/q9FmkCKDLFhhM1x3V2AZm1UdQU18dJDUGB7ZWVcI7yU
	 H5Imjn1GElC0Q==
Date: Thu, 09 May 2024 03:17:23 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Cc: devicetree@vger.kernel.org, benjamin.tissoires@redhat.co, 
 dmitry.torokhov@gmail.com, krzysztof.kozlowski+dt@linaro.org, 
 jikos@kernel.org, hsinyi@google.com, dianders@google.com, 
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240509064336.9803-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240509064336.9803-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Message-Id: <171524264306.4104969.8390645355822762827.robh@kernel.org>
Subject: Re: [PATCH v1 1/2] dt-bindings: input: i2c-hid: Introduce Ilitek
 ili2900


On Thu, 09 May 2024 14:43:35 +0800, Zhaoxiong Lv wrote:
> From: lvzhaoxiong <lvzhaoxiong@huaqin.corp-partner.google.com>
> 
> The ili2900 touch screen chip same as ilitek ili9882t controller
> has a reset gpio.
> 
> Signed-off-by: lvzhaoxiong <lvzhaoxiong@huaqin.corp-partner.google.com>
> ---
>  Documentation/devicetree/bindings/input/ilitek,ili9882t.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
/Documentation/devicetree/bindings/input/ilitek,ili9882t.yaml:22:5: [error] duplication of key "const" in mapping (key-duplicates)

dtschema/dtc warnings/errors:
make[2]: *** Deleting file 'Documentation/devicetree/bindings/input/ilitek,ili9882t.example.dts'
Documentation/devicetree/bindings/input/ilitek,ili9882t.yaml:22:5: found duplicate key "const" with value "ilitek,ili2900" (original value: "ilitek,ili9882t")
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/input/ilitek,ili9882t.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
/Documentation/devicetree/bindings/input/ilitek,ili9882t.yaml:22:5: found duplicate key "const" with value "ilitek,ili2900" (original value: "ilitek,ili9882t")
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/ilitek,ili9882t.yaml: ignoring, error parsing file
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1430: dt_binding_check] Error 2
make: *** [Makefile:240: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240509064336.9803-1-lvzhaoxiong@huaqin.corp-partner.google.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


