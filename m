Return-Path: <linux-kernel+bounces-284460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC9C95012B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C2D4282A5A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C43187348;
	Tue, 13 Aug 2024 09:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWvZq02D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BEE13A894;
	Tue, 13 Aug 2024 09:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541193; cv=none; b=cWbqSCZi85b0VCU/smCyZST/ViEtfGcp82w9q2KpJpS+HjEYljQ5SsJvMQVw/dpohYav8oz8TG+Kad4vo28Wzcl17t5rWImHOLw/C8hJ2DUvQ+6yJOJL9/MbCGGwWUP3sSnpuJXdy6vnlAVwc3h0bUc+0F6tOdAeUJQ/CzpaHsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541193; c=relaxed/simple;
	bh=NSzsztjiA9iy3UQR7+ew34K14a/ro09VqScy6tDCXKk=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=Ei8P693Ir1ARe6y0NuAoyRPzoLwb6ytGXxWDwhzkGYckUmOuyssD0vrZ0U5lQ7vN3ypoorHWAAZYhL45qWuwPGgG7vuoa8KgcvSgR5qNVzEMFGiJRYqmZR5FRjTwfbozTDQP8dnT2L97yYySvXZiIKNMWA8ZT+Mk9Qs12Wll6MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWvZq02D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F1CC4AF09;
	Tue, 13 Aug 2024 09:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723541192;
	bh=NSzsztjiA9iy3UQR7+ew34K14a/ro09VqScy6tDCXKk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=QWvZq02DqjnOJ8grMe/TvFnytAuJca5DVG9WRx1yEcrcQ1RX5FRZZqPtZzzbDa936
	 8l22+Vqig7fwaTjtkJQOGW6B7ZetdBgbrAP1O9wISlPCGMBXrj8R0NH6uUXDvrQ6iG
	 HS6jfqdTsbH9jSlzcwIanIpyCDu29XNUKUYE+jspQC96gYz63apMMSmAck4c0E7jKM
	 TEN5IJtNkeXh+S4N8a4qwVlT1Ph+KbLbHorGBZ5m62LwsxuYjDk7k+90qEh5+KHrkE
	 Fw4qR+LfR69M1QNjEwRzpQNooVYXugiLxICb3hqDfAQLYxQGGGgiDagL38fI6txIZC
	 E5G1D9Oznapkw==
Date: Tue, 13 Aug 2024 03:26:30 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kevin Chen <kevin_chen@aspeedtech.com>
Cc: krzk+dt@kernel.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 tglx@linutronix.de, conor+dt@kernel.org, andrew@codeconstruct.com.au, 
 joel@jms.id.au, devicetree@vger.kernel.org
In-Reply-To: <20240813074338.969883-2-kevin_chen@aspeedtech.com>
References: <20240813074338.969883-1-kevin_chen@aspeedtech.com>
 <20240813074338.969883-2-kevin_chen@aspeedtech.com>
Message-Id: <172354119091.52485.8216967911640529962.robh@kernel.org>
Subject: Re: [PATCH v1 1/2] dt-bindings: interrupt-controller: Add support
 for ASPEED AST27XX INTC


On Tue, 13 Aug 2024 15:43:37 +0800, Kevin Chen wrote:
> The ASPEED AST27XX interrupt controller(INTC) combines 32 interrupt
> sources into 1 interrupt into GIC from CPU die to CPU die.
> The INTC design contains soc0_intc and soc1_intc module doing hand shake
> between CPU die and IO die INTC.
> 
> In soc0_intc11, each bit represent 1 GIC_SPI interrupt from soc1_intcX.
> In soc1_intcX, each bit represent 1 device interrupt in IO die.
> 
> By soc1_intcX in IO die, AST27XX INTC combines 32 interrupt sources to
> 1 interrupt source in soc0_intc11 in CPU die, which achieve the
> interrupt passing between the different die in AST27XX.
> ---
>  .../aspeed,ast2700-intc.yaml                  | 120 ++++++++++++++++++
>  1 file changed, 120 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml:24:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml:25:11: [warning] wrong indentation: expected 12 but found 10 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml: 'example' is not one of ['$id', '$schema', 'title', 'description', 'examples', 'required', 'allOf', 'anyOf', 'oneOf', 'definitions', '$defs', 'additionalProperties', 'dependencies', 'dependentRequired', 'dependentSchemas', 'patternProperties', 'properties', 'not', 'if', 'then', 'else', 'unevaluatedProperties', 'deprecated', 'maintainers', 'select', '$ref']
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240813074338.969883-2-kevin_chen@aspeedtech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


