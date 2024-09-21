Return-Path: <linux-kernel+bounces-334900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2E897DE1A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 19:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03FB91F210E8
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 17:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9FE178367;
	Sat, 21 Sep 2024 17:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="q9QQW7/2"
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A397171066;
	Sat, 21 Sep 2024 17:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726940605; cv=none; b=l7Q91Dvc/LQC18Q4khYYO0FHM0XCuHBS65qdjvom/LHBjfpWmZ5pH14qk+DDaMpmwKqPI2MtWxlMRCqedBUeJMwSv+FPcFiFrMlcskRBv2SHQhYwDMID9Gf/j1UJyOGCKsWr/BO5R4nbsbpgPgMuBLuc1wZndLtmPa/WkU9XC3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726940605; c=relaxed/simple;
	bh=5QF4E4hzhN8h7TsKm+fffMA2RL3nFR24AROMzPXbtFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DdqLioZvg62mbR0zBhUGC60wmbkzVb0PBiGXeDR5L7n7otYcgEr4Jkm3LdkyBZ6ctnEk1ki31izbmIP9qxRGs3UGO9yk8jRTbTwTJL4j6ijbN8sJr4FQRFRoCKj+3lGd8BSbhaHphBqxjwydmpL/7Q+yavtmvd9vRohMMd/q74M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=q9QQW7/2; arc=none smtp.client-ip=80.12.242.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id ruJZsXjomPdk1ruJZsOId7; Sat, 21 Sep 2024 09:14:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1726902842;
	bh=QoQYT2Kirtlhg7admjb2GZK6gh+y5+OeCj824zlA4lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=q9QQW7/2qUU/H+3J4lHfhbWi2/Qn8JCiKcQ+z9ZnxRyoZoI6eOcjrkvjbKbrmg1US
	 OkEhmLpMrIM8TzaZqcWrmtFLAL52kvxlO6YWCk3GAKU0Ph5YoR/LY1lXSjiEAKzUiY
	 iemIfOdNyLRK2qaGlogwb80pU8GJuZDBwYJVfULA3HjMi6nnxSrnDFJHoqUmZHNAN9
	 cqvE43PmAK1BXHn75Fd7pDAAEGpV3x+qElS1NpE5iGMXIbE+GIHQVJ/bhiFkBmgANq
	 lf+SA6Xq5OnJUg/VYh6xbybv8+FtYcn3gz/wKGnA9QBN46lz+O+8wXGY0/jddUcpr1
	 PjHhFmOw2aOoA==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sat, 21 Sep 2024 09:14:02 +0200
X-ME-IP: 90.11.132.44
Message-ID: <33519933-f171-4bbe-adad-dbe51115cc0a@wanadoo.fr>
Date: Sat, 21 Sep 2024 09:13:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] platform/x86: asus-armoury: move existing tunings
 to asus-armoury module
To: "Luke D. Jones" <luke@ljones.dev>, platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, corentin.chary@gmail.com
References: <20240918094250.82430-1-luke@ljones.dev>
 <20240918094250.82430-2-luke@ljones.dev>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240918094250.82430-2-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 18/09/2024 à 11:42, Luke D. Jones a écrit :
> The fw_attributes_class provides a much cleaner interface to all of the
> attributes introduced to asus-wmi. This patch moves all of these extra
> attributes over to fw_attributes_class, and shifts the bulk of these
> definitions to a new kernel module to reduce the clutter of asus-wmi
> with the intention of deprecating the asus-wmi attributes in future.
> 
> The work applies only to WMI methods which don't have a clearly defined
> place within the sysfs and as a result ended up lumped together in
> /sys/devices/platform/asus-nb-wmi/ with no standard API.
> 
> Where possible the fw attrs now implement defaults, min, max, scalar,
> choices, etc. As en example dgpu_disable becomes:
> 
> /sys/class/firmware-attributes/asus-armoury/attributes/dgpu_disable/
> ├── current_value
> ├── display_name
> ├── possible_values
> └── type
> 
> as do other attributes.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>

Hi,

a few nitpick below, should it help.

> +/* Boolean style enumeration, base macro. Requires adding show/store */
> +#define __ATTR_GROUP_ENUM(_attrname, _fsname, _possible, _dispname)     \
> +	__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);    \
> +	__ATTR_SHOW_FMT(possible_values, _attrname, "%s\n", _possible); \
> +	static struct kobj_attribute attr_##_attrname##_type =          \
> +		__ASUS_ATTR_RO_AS(type, enum_type_show);                \
> +	static struct attribute *_attrname##_attrs[] = {                \
> +		&attr_##_attrname##_current_value.attr,                 \
> +		&attr_##_attrname##_display_name.attr,                  \
> +		&attr_##_attrname##_possible_values.attr,               \
> +		&attr_##_attrname##_type.attr, NULL                     \

It would be more readable if ", NULL" was on its own line, IMHO.

> +	};                                                              \
> +	static const struct attribute_group _attrname##_attr_group = {  \
> +		.name = _fsname, .attrs = _attrname##_attrs             \
> +	}
> +
> +#define ATTR_GROUP_BOOL_RO(_attrname, _fsname, _wmi, _dispname) \
> +	__ATTR_CURRENT_INT_RO(_attrname, _wmi);                 \
> +	__ATTR_GROUP_ENUM(_attrname, _fsname, "0;1", _dispname)
> +
> +#define ATTR_GROUP_BOOL_RW(_attrname, _fsname, _wmi, _dispname) \
> +	__ATTR_CURRENT_INT_RW(_attrname, 0, 1, _wmi);           \
> +	__ATTR_GROUP_ENUM(_attrname, _fsname, "0;1", _dispname)
> +
> +/*
> + * Requires <name>_current_value_show(), <name>_current_value_show()
> + */
> +#define ATTR_GROUP_BOOL_CUSTOM(_attrname, _fsname, _dispname)           \
> +	static struct kobj_attribute attr_##_attrname##_current_value = \
> +		__ASUS_ATTR_RW(_attrname, current_value);               \
> +	__ATTR_GROUP_ENUM(_attrname, _fsname, "0;1", _dispname)
> +
> +#define ATTR_GROUP_ENUM_INT_RO(_attrname, _fsname, _wmi, _possible, _dispname) \
> +	__ATTR_CURRENT_INT_RO(_attrname, _wmi);                                \
> +	__ATTR_GROUP_ENUM(_attrname, _fsname, _possible, _dispname)
> +
> +/*
> + * Requires <name>_current_value_show(), <name>_current_value_show()
> + * and <name>_possible_values_show()
> + */
> +#define ATTR_GROUP_ENUM_CUSTOM(_attrname, _fsname, _dispname)             \
> +	__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);      \
> +	static struct kobj_attribute attr_##_attrname##_current_value =   \
> +		__ASUS_ATTR_RW(_attrname, current_value);                 \
> +	static struct kobj_attribute attr_##_attrname##_possible_values = \
> +		__ASUS_ATTR_RO(_attrname, possible_values);               \
> +	static struct kobj_attribute attr_##_attrname##_type =            \
> +		__ASUS_ATTR_RO_AS(type, enum_type_show);                  \
> +	static struct attribute *_attrname##_attrs[] = {                  \
> +		&attr_##_attrname##_current_value.attr,                   \
> +		&attr_##_attrname##_display_name.attr,                    \
> +		&attr_##_attrname##_possible_values.attr,                 \
> +		&attr_##_attrname##_type.attr, NULL                       \

It would be more readable if ", NULL" was on its own line, IMHO.

> +	};                                                                \
> +	static const struct attribute_group _attrname##_attr_group = {    \
> +		.name = _fsname, .attrs = _attrname##_attrs               \
> +	}

...

> +static const struct dmi_system_id asus_rog_ally_device[] = {
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "RC71L"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "RC72L"),
> +		},
> +	},
> +	{ },

I think that an ending comma is not expected after a terminator.

> +};
> +
>   #endif /* !_ASUS_WMI_H_ */

...

CJ


