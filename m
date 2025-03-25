Return-Path: <linux-kernel+bounces-575487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2956DA70340
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 916383A99F0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5A72586E7;
	Tue, 25 Mar 2025 14:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XgCAV8aD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B23E2571B4;
	Tue, 25 Mar 2025 14:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742911298; cv=none; b=kFTRPvKNU3reVSZwRRNvyangJ9NyMoqRAckYYjRsx6fqiNd4BvgB9bZnUHz8EXXfC+NvtOs4ecO0/NdyZ9KV/8emEjEbijwCrQq0bMEiCwj4yRr/j8mF4rPm4bOrybIKjPVyHztPw7sAd8r+HZNXl64Xx9YFe6JOfjnaZskT1TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742911298; c=relaxed/simple;
	bh=KKBnNn/S4R4f5Mz5eckMo80BqvJaP7VN+nATZxJyyCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEVbDFlcnwEM4dyq+7g2zUOSysKAIM6MwQZpPupcoLl59d+CZlmhEp0kKTkDgKAtOg8/vYmd74NCtzCDFHaN1n7Fp4JMPa7JSfU/v4zNVO/ozRq28gH+qlLIQ6s0dFTb5XWcYVPielbIXyMCbtaDN5CGHvVauOp/fXAIWAWwUT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XgCAV8aD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA819C4CEE4;
	Tue, 25 Mar 2025 14:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742911298;
	bh=KKBnNn/S4R4f5Mz5eckMo80BqvJaP7VN+nATZxJyyCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XgCAV8aD40fxO0b7OxsOFkRnwVnu8aifYiSg1YvkIwDHtvgaY7AtBSFGIGERIh9Oj
	 a3XApPyiUgMIRnA3XnKi/bZfHKDqWhCAYO0kygaSMCtlOC40WrSP9pIK4LJdBv43mo
	 1zBFTC86JK1sovpU9sN9pFp9aPZvKRXLOpXvMZLDui5k9i6BWsNZG1/hXW7kofo/jn
	 c4AZ5QJuLVECUCi6k7TQlNO9SIdcbQW/oRjG7DHxs6/Ki1wze6GMMxw63zpfwwUI5v
	 JMonbhDHYSi9OzHEZXzSsmMJXE+oNuzMlqmQfCb56C0FK85tWQPu9iisFXJe9mTC1S
	 EcGvfOMaNe57g==
Date: Tue, 25 Mar 2025 09:01:36 -0500
From: Rob Herring <robh@kernel.org>
To: Guomin chen <guomin.chen@cixtech.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Chen <peter.chen@cixtech.com>,
	cix-kernel-upstream@cixtech.com, linux-kernel@vger.kernel.org,
	Jassi Brar <jassisinghbrar@gmail.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: mailbox: add cix,sky1-mbox
Message-ID: <20250325140136.GA1843686-robh@kernel.org>
References: <20250325101807.2202758-1-guomin.chen@cixtech.com>
 <20250325101807.2202758-2-guomin.chen@cixtech.com>
 <174290730775.1655008.14031380406017771195.robh@kernel.org>
 <Z+KxIRVRRw1slKqB@gchen>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z+KxIRVRRw1slKqB@gchen>

On Tue, Mar 25, 2025 at 01:35:29PM +0000, Guomin chen wrote:
> On Tue, Mar 25, 2025 at 07:55:10AM -0500, Rob Herring (Arm) wrote:
> > [Some people who received this message don't often get email from robh@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > EXTERNAL EMAIL
> > 
> > On Tue, 25 Mar 2025 10:18:06 +0000, Guomin Chen wrote:
> > > From: Guomin Chen <Guomin.Chen@cixtech.com>
> > >
> > > Add a dt-binding for the Cixtech Mailbox Controller.
> > >
> > > Reviewed-by: Peter Chen <peter.chen@cixtech.com>
> > > Signed-off-by: Lihua Liu <Lihua.Liu@cixtech.com>
> > > Signed-off-by: Guomin Chen <Guomin.Chen@cixtech.com>
> > > ---
> > >  .../bindings/mailbox/cix,sky1-mbox.yaml       | 80 +++++++++++++++++++
> > >  1 file changed, 80 insertions(+)
> > >
> > 
> > My bot found errors running 'make dt_binding_check' on your patch:
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> ...
> >  l,.*', 'pinctrl-[0-9]+'
> >         from schema $id: http://devicetree.org/schemas/vendor-prefixes.yaml#
> > 
> > doc reference errors (make refcheckdocs):
> > 
> > See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250325101807.2202758-2-guomin.chen@cixtech.com
> > 
> > The base for the series is generally the latest rc1. A different dependency
> > should be noted in *this* patch.
> > 
> > If you already ran 'make dt_binding_check' and didn't see the above
> > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > date:
> > 
> > pip3 install dtschema --upgrade
> > 
> > Please check and re-submit after running the above command yourself. Note
> > that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> > your schema. However, it must be unset to test all examples with your schema.
> > 
> 
> Thank you very much. 
> Although I have already run 'make dt_binding_check DT_SCHEMA_FILES=mailbox/cix,sky1-mbox.yaml' in my environment.
> I will try updating dtschema and re-check it.

With DT_SCHEMA_FILES you only check what matches. You have to run 
without it.

Rob


