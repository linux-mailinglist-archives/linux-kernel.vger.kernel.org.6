Return-Path: <linux-kernel+bounces-253119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9FE931CB5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 23:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A30ADB223D6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 21:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B4513C9C8;
	Mon, 15 Jul 2024 21:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKbBcDjK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F032913C807;
	Mon, 15 Jul 2024 21:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721079802; cv=none; b=VjM0IIBaqgeo/bomV5WWUewc7g9t7zHcln00fea6B3oStl900WUFKWVDyCVhU92bGUxnJ7NZNxubKPU0gT3Zbc61JnAc6x7XiguO/0PYPS/MB5V15DsdI8mdSdrQqvRHTJwMmWW93axTL561bo1mIL9nSIV18oQjqPiYsl4fA1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721079802; c=relaxed/simple;
	bh=T+QZtx2h4IduRZk0idxoI2YILjDJIPQFE6ClNUWQLP4=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=V9XdVDxWrQCSGpOdKf6rQI483R78YG+iwMrPyFXeUV/0De5XGzai7f/YsHby2jxy57xG8q+AOJXzn5z+Y+C/U9jHBA7T7b4RjVjoQ/JqMSOPqD/yiajJ44gKLAWoak1L0JzaLsZK6LMY150CPe7EY2scoa20Sqvar5WM34wHKOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKbBcDjK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E1DC32782;
	Mon, 15 Jul 2024 21:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721079801;
	bh=T+QZtx2h4IduRZk0idxoI2YILjDJIPQFE6ClNUWQLP4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=dKbBcDjKIp79JdN6eAA3Og3IUymkMs28WgwmtrRoIHGv2o3pasmG0PmDS8Qc9lrG/
	 /Zbqd3hx4PCkBFYd2fHrZ0EuFT+JMLCpI3L4H6/kAp4F09hP8ymwUJOYiqulGbWget
	 eGAkQepUsN+pAHpSaUZVG+fUwBdXKisUqxId9LCJg72OJC3W8UKTEdpYj2lh7amgxj
	 Z3o3qgBmcXTE4jcDeniZX7LvQ8UMieds67It1miyyEil5zdK0jWt4b0kELTE393mns
	 wcGxhnEBEbXyOxzHINllXBMgdnBiGU7qfbtPGOYVBEu33YeCcPjVbk/1Th4dPUD/j3
	 FdmTLXtAA0uZA==
Date: Mon, 15 Jul 2024 15:43:19 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Aradhya Bhatia <a-bhatia1@ti.com>
Cc: Devicetree List <devicetree@vger.kernel.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Jai Luthra <j-luthra@ti.com>, 
 David Airlie <airlied@gmail.com>, 
 Linux Kernel List <linux-kernel@vger.kernel.org>, 
 Jayesh Choudhary <j-choudhary@ti.com>, Conor Dooley <conor+dt@kernel.org>, 
 Udit Kumar <u-kumar1@ti.com>, Randolph Sapp <rs@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Jyri Sarha <jyri.sarha@iki.fi>, 
 Nishanth Menon <nm@ti.com>, Devarsh Thakkar <devarsht@ti.com>, 
 Praneeth Bajjuri <praneeth@ti.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 DRI Development List <dri-devel@lists.freedesktop.org>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20240715200953.1213284-4-a-bhatia1@ti.com>
References: <20240715200953.1213284-1-a-bhatia1@ti.com>
 <20240715200953.1213284-4-a-bhatia1@ti.com>
Message-Id: <172107979988.1595945.9666141982402158422.robh@kernel.org>
Subject: Re: [PATCH v2 3/4] dt-bindings: display: ti,am65x-dss: Add OLDI
 properties for AM625 DSS


On Tue, 16 Jul 2024 01:39:52 +0530, Aradhya Bhatia wrote:
> The DSS in AM625 SoC has 2 OLDI TXes. Refer the OLDI schema to add the
> support for the OLDI TXes.
> 
> The AM625 DSS VP1 (port@0) can connect and control 2 OLDI TXes, to use
> them in dual-link or cloned single-link OLDI modes. Add support for an
> additional endpoint under the port@0 to accurately depict the data flow
> path.
> 
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> ---
>  .../bindings/display/ti/ti,am65x-dss.yaml     | 134 ++++++++++++++++++
>  1 file changed, 134 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml: oldi-txes: Missing additionalProperties/unevaluatedProperties constraint

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240715200953.1213284-4-a-bhatia1@ti.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


