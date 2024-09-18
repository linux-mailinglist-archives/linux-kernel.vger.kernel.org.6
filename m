Return-Path: <linux-kernel+bounces-332978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 543FE97C1CB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 00:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 862481C20E40
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 22:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242D51CB32D;
	Wed, 18 Sep 2024 22:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQLMRa69"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758FF107A0;
	Wed, 18 Sep 2024 22:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726697348; cv=none; b=TpIJXGVawzon1QTB0W6iyAudgoqsslCoF1DUuWqjIgEElqqq/z34hfKBLGN0rNywzHkJVXYDyiVy8pmG6el/U8yi6xd0cDBvW/jSdD6LFsGUOx5RnP+8Vdt7gSIPhAl+M0xTLpbTeXkgn1fX37ZytoXmQK2xnRfTeRL16jkOm+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726697348; c=relaxed/simple;
	bh=Xgf+hjqyDaXQyjdCBei1soDh4wnJzkSOhfi7BqmGFxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYtw0dtNtsMNwhSu66D8kDbKKkBIDce+Y5mhQO0TQcKKQMP+eNFJXX9xgyfqNJJuk0+OL1YWGzKnisKVnD+/9JvuiuesC2i47KjKzvZKk/5GHp0thL91uFZ2+v62AD7+Hbwwn/nUqFCx4dGN3bAj008YHLjOMg7xovCgRHtaang=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQLMRa69; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC59C4CEC7;
	Wed, 18 Sep 2024 22:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726697347;
	bh=Xgf+hjqyDaXQyjdCBei1soDh4wnJzkSOhfi7BqmGFxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JQLMRa69ANkOzO86vj+aFyam9SUtWY79j5b5oK+jVk2g+eiJz4ve+hHNQgq5lFfgm
	 0oDyzWK3WYz5+AoFxzndeH3Q2jN7HkIEJjtT39gIYGj4b0dx60yDUjgxvqA/FmgrF2
	 ePqzysD3+EVGYacnmxTvkdF05BsvEIpxzIYji7lOiqk2rawjwmlsfUsX8i08taTwgx
	 yyhIYsWR+ccD5kNGm4gDjWu9ab6ucAS6JFn+KxAbjtRY4GVsMvWlTDiYKY9e8Lr6F0
	 ca9crROvWl48dqk3/r3EXaRT6qrmbHedhbwDbdj5E5VDycpeCHvk49gLsj0OBM6WNF
	 +0q03Ne1GEL/Q==
Date: Wed, 18 Sep 2024 17:09:06 -0500
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Chanh Nguyen <chanh@os.amperecomputing.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	OpenBMC Maillist <openbmc@lists.ozlabs.org>,
	Open Source Submission <patches@amperecomputing.com>,
	Phong Vo <phong@os.amperecomputing.com>,
	Thang Nguyen <thang@os.amperecomputing.com>,
	Quan Nguyen <quan@os.amperecomputing.com>,
	Khanh Pham <khpham@amperecomputing.com>
Subject: Re: [PATCH] dt-bindings: hwmon: Add adt7462
Message-ID: <20240918220906.GB2216504-robh@kernel.org>
References: <20240918103212.591204-1-chanh@os.amperecomputing.com>
 <bc13d8fd-4f03-4445-bc4a-1e0ca7c23ef7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc13d8fd-4f03-4445-bc4a-1e0ca7c23ef7@kernel.org>

On Wed, Sep 18, 2024 at 03:09:23PM +0200, Krzysztof Kozlowski wrote:
> On 18/09/2024 12:32, Chanh Nguyen wrote:
> > Add device tree binding and example for adt7462 device.
> > 
> > Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
> > ---
> >  .../bindings/hwmon/onnn,adt7462.yaml          | 51 +++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> 
> Where is any user? This is supposed to be sent along driver change
> implementing this compatible.

Since I2C subsystem will strip the vendor prefix and match "adt7462" to 
the existing i2c_device_id, no driver change is needed for it to work. 
Though for good hygene, an of_device_id entry should be added.

Rob

