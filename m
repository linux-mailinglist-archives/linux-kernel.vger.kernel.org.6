Return-Path: <linux-kernel+bounces-445367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECCE9F151A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BEEE7A0F92
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D901EBA0B;
	Fri, 13 Dec 2024 18:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2PyXOo7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3001EB9E3;
	Fri, 13 Dec 2024 18:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734115301; cv=none; b=l75M8NjJvijx4uXZXpEHzewm8pKBELDeLDL3MRcfR//3sHmxMEykekOGjho4wf1mNEuLp8kZMJpwUijJD8drwXP0qytJQOzzxmr/DjD+tWqCatbl0KTEyRgQ6BwhJ6mm4o4RPQ327dA86bEaTdXChC0QsarIoTco09PZZj1usac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734115301; c=relaxed/simple;
	bh=l5wBYY7ZX7n9ON3/zYZfPE7II8BV65XxsMq2inJ5tMA=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=aEBO3BwfvazpMZNo5dP3ytnz6yAdgvonrrcH/uc3YB0bCdDOqpMStZJzvcB5V2qTyPFxDLG3+rnvB+sHYl2vimOgB0Z9Gpud3gmKN230jybuvT4LrdnLDQ64Y+4k/M+2qSNgKGN7R3OAmDxJvZjWvRR+wpCURioPM2GzPGC+baM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2PyXOo7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5948AC4CED1;
	Fri, 13 Dec 2024 18:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734115300;
	bh=l5wBYY7ZX7n9ON3/zYZfPE7II8BV65XxsMq2inJ5tMA=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=P2PyXOo7U4lFzmg3Lav9okVaqFhQAO9Yfr0uUIh8s1bu1hCRJS08q/0oJ0hwfOPrd
	 wo07+M5qVKzSWFiwwWWcgE9IandSNrlbpX+FN4n9h3cJKM3uaKhR+cGUCRlDrKMzFR
	 e3Bj2W+NSstl9PjkvqtKG/U3bM1klucbFeWeKGeLGRseUBeIQkp4/Ps9tRMOHhKRVN
	 9mcSBdy5lCiIjPDLEHrmh7TPihaBcOGDDK69TuydMQ/4bMr8mhk1VqmCtmDV1pBfAU
	 KaGCOpiSPaTDIT7e52bu7hzHag9nZdWT3w9OpE5wiiLSY/7SDv+I145F/7mG+/O+7J
	 aEF+nBwjjmUpA==
Date: Fri, 13 Dec 2024 12:41:38 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, 
 linux-kernel@vger.kernel.org, 
 Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <20241213165240.3652961-3-vincenzo.frascino@arm.com>
References: <20241213165240.3652961-1-vincenzo.frascino@arm.com>
 <20241213165240.3652961-3-vincenzo.frascino@arm.com>
Message-Id: <173411529611.1995394.4426135124914392521.robh@kernel.org>
Subject: Re: [PATCH 2/3] xlnx: dt-bindings: xlnx,audio-formatter: Convert
 to json-schema


On Fri, 13 Dec 2024 16:52:39 +0000, Vincenzo Frascino wrote:
> Convert the Xilinx Audio Formatter 1.0  device tree binding documentation
> to json-schema.
> 
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  .../bindings/sound/xlnx,audio-formatter.txt   | 29 -------
>  .../bindings/sound/xlnx,audio-formatter.yaml  | 84 +++++++++++++++++++
>  2 files changed, 84 insertions(+), 29 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/xlnx,audio-formatter.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/xlnx,audio-formatter.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/xlnx,audio-formatter.yaml: title: 'Device-Tree bindings for Xilinx PL audio formatter' should not be valid under {'pattern': '([Bb]inding| [Ss]chema)'}
	hint: Everything is a binding/schema, no need to say it. Describe what hardware the binding is for.
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/xlnx,audio-formatter.example.dtb: audio_formatter@80010000: reg: [[0, 2147549184], [0, 4096]] is too long
	from schema $id: http://devicetree.org/schemas/sound/xlnx,audio-formatter.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/xlnx,audio-formatter.example.dtb: audio_formatter@80010000: interrupts-parent: b'\xff\xff\xff\xff' is not of type 'array'
	from schema $id: http://devicetree.org/schemas/sound/xlnx,audio-formatter.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/xlnx,audio-formatter.example.dtb: audio_formatter@80010000: interrupts-parent: b'\xff\xff\xff\xff' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241213165240.3652961-3-vincenzo.frascino@arm.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


