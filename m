Return-Path: <linux-kernel+bounces-511554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 910EDA32C8B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C2CC3A922B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465CE255E5D;
	Wed, 12 Feb 2025 16:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHsSCn8X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814AF255E27;
	Wed, 12 Feb 2025 16:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379223; cv=none; b=cWY4a2wr5EFQimOvmkYgOd6dJoO+lFc+7HkYQea0EqM6RN3Bh9TysgGzA656RMzrXC+0Fj8LghpCl5ez/Mh2ivjUolZlbMURYL731ZuXd5vo/Aaunkf7a7pOAeW/g7NscY5PjBZOocnQFM5//CR5I/YGKNgCjFMpzBQiebFGmAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379223; c=relaxed/simple;
	bh=mr8GjH+15lBi8VHein+7pK0kYx+HbXlrW0PLl41bbgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tKGm7qap8Rk2TV33crZhCTR+umATADhH2vyJTxNHESduEMr7094z+8v9FCKEKhueHaB5LpDY2fhHx7pujhEOx66xbiI4U9uvCGR3M/BeO1WfmEgstzcHuWLaSSXW5uap9RdcHNXFQ+BsOZaSj9ZSGy7IjTSwJuj35VKr9YnXRbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHsSCn8X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B51FC4CEDF;
	Wed, 12 Feb 2025 16:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739379221;
	bh=mr8GjH+15lBi8VHein+7pK0kYx+HbXlrW0PLl41bbgI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iHsSCn8XJSMVzS2R2YduVzicWLVtjzBlcvyemeAYYOK5ilrQ92vm7KYHmjDSgKUVB
	 FsBw7NG5juZw7q/grxpAJvQDYrkN+qugXz5DzHvaoEdlC/PxEyEJLKRZiWCZSpQz5C
	 8oejDzd6WHTm5IYKdV3TRQPGthgTZ3HAkZ0gr9DiWP23J4i6X33yE5kz19UWvwR6XI
	 KDNH4JVmo2ybhup8V3m/9915Bc/LxvOlcG8lRd4Rox2ybvjIQf4w/sx0kKtJjYfPqY
	 LRMkg1D6iO87JL7blAmgFPzIzOPOUm17LhafOwYmgljLykwFDV423qXJypW7kVDgJO
	 3baJSHEdDOv3A==
Message-ID: <76c991dd-f99b-497c-9d68-9e08541be4f0@kernel.org>
Date: Wed, 12 Feb 2025 17:53:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drivers: i3c: Add driver for NXP P3H2x4x i3c-hub
 device
To: Aman Kumar Pandey <aman.kumarpandey@nxp.com>,
 linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org,
 alexandre.belloni@bootlin.com, krzk+dt@kernel.org, robh@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org
Cc: vikash.bansal@nxp.com, priyanka.jain@nxp.com,
 shashank.rebbapragada@nxp.com, Frank.Li@nxp.com
References: <20250212132227.1348374-1-aman.kumarpandey@nxp.com>
 <20250212132227.1348374-2-aman.kumarpandey@nxp.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20250212132227.1348374-2-aman.kumarpandey@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/02/2025 14:22, Aman Kumar Pandey wrote:
> +
> +static void p3h2x4x_of_get_tp_dt_conf(struct device *dev,
> +					const struct device_node *node)
> +{
> +	struct p3h2x4x *priv = dev_get_drvdata(dev);
> +	struct device_node *dev_node;
> +	int tp_port;
> +
> +	for_each_available_child_of_node(node, dev_node) {
> +		if (!dev_node->full_name ||
> +			(sscanf(dev_node->full_name, "target-port@%d", &tp_port) != 1))

NAK, undocumented ABI. Also weird code, why are you parsing DT structure
manually? Use proper functions to get the reg.



> +			continue;
> +
> +		if (tp_port < P3H2x4x_TP_MAX_COUNT) {
> +			priv->tp_bus[tp_port].dt_available = true;
> +			priv->tp_bus[tp_port].of_node = dev_node;
> +			priv->tp_bus[tp_port].tp_mask = BIT(tp_port);
> +			priv->tp_bus[tp_port].priv = priv;
> +			priv->tp_bus[tp_port].tp_port = tp_port;
> +		}
> +	}
> +}
> +
> +/* return true when backend node exist */
> +static bool p3h2x4x_is_backend_node_exist(int port, struct p3h2x4x *priv, u32 addr)
> +{
> +	struct smbus_device *backend = NULL;
> +
> +	list_for_each_entry(backend,
> +			&priv->tp_bus[port].tp_device_entry, list) {
> +		if (backend->addr == addr)
> +			return true;
> +	}
> +	return false;
> +}
> +
> +static int p3h2x4x_read_backend_from_p3h2x4x_dts(struct device_node *i3c_node_target,
> +					struct p3h2x4x *priv)
> +{
> +	struct device_node *i3c_node_tp;
> +	const char *compatible;
> +	int tp_port, ret;
> +	u32 addr_dts;
> +	struct smbus_device *backend;
> +
> +	if (sscanf(i3c_node_target->full_name, "target-port@%d", &tp_port) == 0)
> +		return -EINVAL;
> +
> +	if (tp_port > P3H2x4x_TP_MAX_COUNT)
> +		return -ERANGE;
> +
> +	if (tp_port < 0)
> +		return -EINVAL;
> +
> +	INIT_LIST_HEAD(&priv->tp_bus[tp_port].tp_device_entry);
> +
> +	if (priv->settings.tp[tp_port].mode == P3H2x4x_TP_MODE_I3C)
> +		return 0;
> +
> +	for_each_available_child_of_node(i3c_node_target, i3c_node_tp) {
> +
> +		ret = of_property_read_u32(i3c_node_tp, "reg", &addr_dts);
> +		if (ret)
> +			return ret;
> +
> +		if (p3h2x4x_is_backend_node_exist(tp_port, priv, addr_dts))
> +			continue;
> +
> +		ret = of_property_read_string(i3c_node_tp, "compatible", &compatible);
> +		if (ret)
> +			return ret;
> +
> +		backend = kzalloc(sizeof(*backend), GFP_KERNEL);
> +		if (!backend)
> +			return -ENOMEM;
> +
> +		backend->addr = addr_dts;
> +		backend->compatible = compatible;
> +		backend->tp_device_dt_node = i3c_node_tp;
> +		backend->client = NULL;
> +
> +		list_add(&backend->list,
> +			&priv->tp_bus[tp_port].tp_device_entry);
> +	}
> +
> +	return 0;
> +}
> +
> +static void p3h2x4x_parse_dt_tp(struct device *dev,
> +				const struct device_node *i3c_node_hub,
> +				struct p3h2x4x *priv)
> +{
> +	struct device_node *i3c_node_target;
> +	int ret;
> +
> +	for_each_available_child_of_node(i3c_node_hub, i3c_node_target) {
> +		if (!strcmp(i3c_node_target->name, "target-port")) {
> +			ret = p3h2x4x_read_backend_from_p3h2x4x_dts(i3c_node_target, priv);
> +			if (ret)
> +				dev_err(dev, "DTS entry invalid - error %d", ret);
> +		}
> +	}
> +}
> +
> +static int p3h2x4x_get_tp_local_device_dt_setting(struct device *dev,
> +					const struct device_node *node, u32 id)
> +{
> +	u8 i;
> +	u32 local_dev_count, local_dev;
> +	struct p3h2x4x *priv = dev_get_drvdata(dev);
> +
> +	if (!of_get_property(node, "local_dev", &local_dev_count))

Oh no, read DTS conding style before upstreaming such code.


Best regards,
Krzysztof

