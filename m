Return-Path: <linux-kernel+bounces-332761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A99E797BE83
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 17:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6796328354D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 15:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB96E1C68B4;
	Wed, 18 Sep 2024 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWu/nLbZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFFE7A15B;
	Wed, 18 Sep 2024 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726672863; cv=none; b=ueNq4LgfzO2FNVgSzK4MDhJfHS6LwHjqRyWPatOF85N0eC+4HLmiK+CXry55XpWit3tXOh2tIPbAVGyr36EDW7dlJUT/h+l//ezIA1dRoaxH5WRENjwrzqXyq0/QtbWPXC0HLznHAjFTWEP6UHDdwWxuOsZceFUNvoR/DjQtoTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726672863; c=relaxed/simple;
	bh=h74MYu0CMAjngiyISC1+qiBUaTaAmY+BF5I44TzOFQk=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=QcDZ4nHV+2zu3TvX7js77NZdnDf3NTFYBCddcf55oayEeVDUIs1gDxwR3BY8ZtJg0yxRuGnewwlL55CcoyF2GU3L7g95o3RzP50Z0XVT6SUoF9Ju0aZmKdI0aPqwYECPDaWOWF7FIzOBLUr5GSD6HyrKnLfASLITwGVyIXgHEk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWu/nLbZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9FE6C4CEC3;
	Wed, 18 Sep 2024 15:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726672862;
	bh=h74MYu0CMAjngiyISC1+qiBUaTaAmY+BF5I44TzOFQk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=YWu/nLbZF3y4sdm/3OduIKLe/XT4R7y2ikUHgB9K/VBfEdIy4ceX09gq/1MTt3pSi
	 /4Re/5YjjHtrwq9+Nta1Tjw3ozq9fHWYv/OaKnVjdm4FMjxB8uLm+hBecPV4EDo/TL
	 0+GXxGvauyUN5CCvgBjq++XCk7V9Npwl4+hkLiZYlm6sdb/VJR4YsEopLu/NIksnq4
	 jwJyoV6pV0uH92gt507H9I1YmLL1Tt2yjOzMqTpfXzAnr0IxBsk0gbDDt5TFEm6AoQ
	 doALZonCIQ0vC6nZjdEFnc1qzuu9Lk7Yrzg/ezWY5Xdi2KN7VccEkvvuhMcEKVldj4
	 nHRu8GVXCnhSA==
Date: Wed, 18 Sep 2024 10:21:01 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: devicetree@vger.kernel.org, wefu@redhat.com, guoren@kernel.org, 
 paul.walmsley@sifive.com, palmer@dabbelt.com, drew@pdp7.com, 
 krzk+dt@kernel.org, aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org, 
 m.szyprowski@samsung.com, conor+dt@kernel.org, linux-kernel@vger.kernel.org, 
 jassisinghbrar@gmail.com
In-Reply-To: <20240918134901.193033-3-m.wilczynski@samsung.com>
References: <20240918134901.193033-1-m.wilczynski@samsung.com>
 <CGME20240918134926eucas1p1df23a583b356505939d4c5501bd6c80f@eucas1p1.samsung.com>
 <20240918134901.193033-3-m.wilczynski@samsung.com>
Message-Id: <172667286158.1610121.8972324212190229160.robh@kernel.org>
Subject: Re: [PATCH RFC v1 2/3] dt-bindings: mailbox: Add
 thead,th1520-mailbox bindings


On Wed, 18 Sep 2024 15:49:00 +0200, Michal Wilczynski wrote:
> Add bindings for the mailbox controller. This work is based on the vendor
> kernel. [1]
> 
> Link: https://github.com/revyos/thead-kernel.git [1]
> 
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  .../bindings/mailbox/thead,th1520-mbox.yaml   | 83 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.example.dts:31.28-29 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.lib:442: Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1432: dt_binding_check] Error 2
make: *** [Makefile:224: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240918134901.193033-3-m.wilczynski@samsung.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


