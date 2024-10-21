Return-Path: <linux-kernel+bounces-374194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BFD9A66A6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 630791F22E5A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA34E1E573D;
	Mon, 21 Oct 2024 11:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0skQusc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181A0946C;
	Mon, 21 Oct 2024 11:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729510451; cv=none; b=t0LCmsGhqI+8XEqjKYw3ZB0u6H99+i0OG5pLy6O/0T6iGCtvm8y8EvcjHVG0TTHD18KEAtK6QyxsI0aFoeMwO2MaRuaV2ZjfSaIpSrJMFZB65n1laDxKT+dqICIfRfAgRVi6PulBSlY9od+qr7ejVccpETyAKQgcDAxRx+1mZLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729510451; c=relaxed/simple;
	bh=tQq0AcugWJikO4qAz6G4zvSe6n0MN+aqiIaEvzVU4bw=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=LVNirWEL4HXK3eLhFyWHE6X2XwlbEox0hzYCFuFZHzPBhGLxQoEsVjU/vIph8kb4cngV4gf9R7B28SGFEgNtMWgWvXqtQSHAUcRbv4y/1oQ2AkOYU++9SM9Sk/LyfqgjYjxaWW311zXDoH2YnqLkPmDCTnYmArwRnq527zBr2A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0skQusc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556EDC4CEC3;
	Mon, 21 Oct 2024 11:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729510450;
	bh=tQq0AcugWJikO4qAz6G4zvSe6n0MN+aqiIaEvzVU4bw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Z0skQuscOBi0vzATaKpzvTvPrr5QW0YhzlNZ0yzhQQkmIQyYEIL72KgXHn5OCS4fc
	 M8hyRIgQyf3y0SymL9DNs/1VbXUVmZo9+GM1NrmgFV9s+IMyqY4YALZyU4hfBRPtT+
	 xNxeKd7XJtw7xn3U6lL6+KorsDDw53BAIOkxWaZHVRSOHRI2oOfiXouLbfSmsB+czO
	 krNfCyhPeclmgDs/sO8eRRrm9FmHGEum75K4SctC49woxGD9VQ7zclifayRGEOJiNy
	 bnWUr5zIkD3G1f4TSFlnd7SgLODGUNOOaJKJT+PyRnhikZW5EI4fQqXA7jHwtMH505
	 8YI5Q9bpngeNg==
Date: Mon, 21 Oct 2024 06:32:03 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: jdelvare@suse.com, linux-kernel@vger.kernel.org, linux@roeck-us.net, 
 devicetree@vger.kernel.org, sylv@sylv.io, linux-hwmon@vger.kernel.org, 
 conor+dt@kernel.org, krzk+dt@kernel.org
In-Reply-To: <20241021091430.3489816-1-naresh.solanki@9elements.com>
References: <20241021091430.3489816-1-naresh.solanki@9elements.com>
Message-Id: <172951032336.3278738.7867634069843302759.robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: hwmon: pmbus: Add bindings for Vicor
 pli1209bc


On Mon, 21 Oct 2024 14:44:29 +0530, Naresh Solanki wrote:
> Remove vicor,pli1209bc from trivial-devices as it requires additional
> properties and does not fit into the trivial devices category.
> 
> Add new bindings for Vicor pli1209bc, a Digital Supervisor with
> Isolation for use with BCM Bus Converter Modules.
> 
> VR rails are defined under regulator node as expected by pmbus driver.
> 
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> ---
> Changes in V2:
> - Squash the two patch in patch into one.
> - Update commit message.
> ---
>  .../bindings/hwmon/pmbus/vicor,pli1209bc.yaml | 62 +++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |  2 -
>  2 files changed, 62 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/pmbus/vicor,pli1209bc.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/pmbus/vicor,pli1209bc.yaml: properties: 'additionalProperties' should not be valid under {'$ref': '#/definitions/json-schema-prop-names'}
	hint: A json-schema keyword was found instead of a DT property name.
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/pmbus/vicor,pli1209bc.yaml: regulators: Missing additionalProperties/unevaluatedProperties constraint

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241021091430.3489816-1-naresh.solanki@9elements.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


